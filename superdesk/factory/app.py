#!/usr/bin/env python
# -*- coding: utf-8; -*-
#
# This file is part of Superdesk.
#
# Copyright 2013, 2014, 2015 Sourcefabric z.u. and contributors.
#
# For the full copyright and license information, please see the
# AUTHORS and LICENSE files distributed with this source code, or
# at https://www.sourcefabric.org/superdesk/license

import os
import eve
import flask
import jinja2
import importlib
import superdesk

from flask_mail import Mail
from eve.auth import TokenAuth
from eve.io.mongo import MongoJSONEncoder, create_index
from eve.render import send_response
from flask_babel import Babel
from flask import g
from babel import parse_locale

from superdesk.celery_app import init_celery
from superdesk.datalayer import SuperdeskDataLayer  # noqa
from superdesk.errors import SuperdeskError, SuperdeskApiError
from superdesk.factory.sentry import SuperdeskSentry
from superdesk.logging import configure_logging
from superdesk.storage import AmazonMediaStorage, SuperdeskGridFSMediaStorage
from superdesk.validator import SuperdeskValidator


class SuperdeskEve(eve.Eve):

    def __getattr__(self, name):
        """Workaround for https://github.com/pyeve/eve/issues/1087"""
        if name in {"im_self", "im_func"}:
            raise AttributeError("type object '%s' has no attribute '%s'" %
                                 (self.__class__.__name__, name))
        return super(SuperdeskEve, self).__getattr__(name)

    def init_indexes(self):
        for resource, resource_config in self.config['DOMAIN'].items():
            mongo_indexes = resource_config.get('mongo_indexes__init')
            if not mongo_indexes:
                continue

            # Borrowed https://github.com/pyeve/eve/blob/22ea4bfebc8b633251cd06837893ff699bd07a00/eve/flaskapp.py#L915
            for name, value in mongo_indexes.items():
                if isinstance(value, tuple):
                    list_of_keys, index_options = value
                else:
                    list_of_keys = value
                    index_options = {}

                # index creation in background
                index_options['background'] = True
                create_index(self, resource, name, list_of_keys, index_options)


def get_app(config=None, media_storage=None, config_object=None, init_elastic=None):
    """App factory.

    :param config: configuration that can override config from ``default_settings.py``
    :param media_storage: media storage class to use
    :param config_object: config object to load (can be module name, module or an object)
    :param init_elastic: obsolete config - kept there for BC
    :return: a new SuperdeskEve app instance
    """

    abs_path = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
    app_config = flask.Config(abs_path)
    app_config.from_object('superdesk.default_settings')
    app_config.setdefault('APP_ABSPATH', abs_path)
    app_config.setdefault('DOMAIN', {})
    app_config.setdefault('SOURCES', {})

    if config_object:
        app_config.from_object(config_object)

    try:
        app_config.update(config or {})
    except TypeError:
        app_config.from_object(config)

    if not media_storage and app_config.get('AMAZON_CONTAINER_NAME'):
        media_storage = AmazonMediaStorage
    elif not media_storage:
        media_storage = SuperdeskGridFSMediaStorage

    app = SuperdeskEve(
        data=SuperdeskDataLayer,
        auth=TokenAuth,
        media=media_storage,
        settings=app_config,
        json_encoder=MongoJSONEncoder,
        validator=SuperdeskValidator,
        template_folder=os.path.join(abs_path, 'templates'))

    app.jinja_options = {'autoescape': False}

    # init client_config with default config
    app.client_config = {
        'content_expiry_minutes': app.config.get('CONTENT_EXPIRY_MINUTES', 0),
        'ingest_expiry_minutes': app.config.get('INGEST_EXPIRY_MINUTES', 0)
    }

    superdesk.app = app

    custom_loader = jinja2.ChoiceLoader([
        jinja2.FileSystemLoader('templates'),
        jinja2.FileSystemLoader(os.path.join(
            os.path.dirname(os.path.dirname(os.path.realpath(__file__))), 'templates'))])

    app.jinja_loader = custom_loader
    app.mail = Mail(app)
    app.sentry = SuperdeskSentry(app)
    babel = Babel(app, configure_jinja=False)
    app.config['BABEL_TRANSLATION_DIRECTORIES'] = '../translations'

    @babel.localeselector
    def get_locale():
        user = getattr(g, 'user', {})
        user_language = user.get('language', app.config.get('DEFAULT_LANGUAGE', 'en'))
        try:
            # Attempt to load the local using Babel.parse_local
            parse_locale(user_language)
        except ValueError:
            # If Babel fails to recognise the locale, then use the default language
            user_language = app.config.get('DEFAULT_LANGUAGE', 'en')

        return user_language

    @app.errorhandler(SuperdeskError)
    def client_error_handler(error):
        """Return json error response.

        :param error: an instance of :attr:`superdesk.SuperdeskError` class
        """
        return send_response(None, (error.to_dict(), None, None, error.status_code))

    @app.errorhandler(403)
    def server_forbidden_handler(error):
        return send_response(None, ({'code': 403, 'error': error.response}, None, None, 403))

    @app.errorhandler(500)
    def server_error_handler(error):
        """Log server errors."""
        return_error = SuperdeskApiError.internalError(error)
        return client_error_handler(return_error)

    @app.after_request
    def after_request(response):
        # fixing previous media prefixes if defined
        if app.config['MEDIA_PREFIXES_TO_FIX'] and app.config['MEDIA_PREFIX']:
            current_prefix = app.config['MEDIA_PREFIX'].rstrip('/').encode()
            for prefix in app.config['MEDIA_PREFIXES_TO_FIX']:
                response.data = response.data.replace(
                    prefix.rstrip('/').encode(), current_prefix
                )
        return response

    init_celery(app)
    installed = set()

    def install_app(module_name):
        if module_name in installed:
            return
        installed.add(module_name)
        app_module = importlib.import_module(module_name)
        if hasattr(app_module, 'init_app'):
            app_module.init_app(app)

    for module_name in app.config.get('CORE_APPS', []):
        install_app(module_name)

    for module_name in app.config.get('INSTALLED_APPS', []):
        install_app(module_name)

    for resource in superdesk.DOMAIN:
        app.register_resource(resource, superdesk.DOMAIN[resource])

    for name, jinja_filter in superdesk.JINJA_FILTERS.items():
        app.jinja_env.filters[name] = jinja_filter

    configure_logging(app.config['LOG_CONFIG_FILE'])

    return app
