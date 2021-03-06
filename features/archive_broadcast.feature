Feature: Archive Broadcast

  @auth @vocabulary
  Scenario: Create Archive Broadcast Content on a desk
    Given "desks"
    """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
    """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get OK response
    And we get updated response
      """
      {
          "type": "text",
          "slugline": "comics",
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "_current_version": 1,
          "urgency": 1,
          "priority": 3,
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "family_id": "xyz",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          },
          "genre": [{"name": "Broadcast Script", "qcode": "Broadcast Script"}],
          "broadcast": {
            "status": "",
            "master_id": "123"
          }
      }
      """
    When we get "archive/#broadcast._id#?version=all"
    Then we get list with 1 items
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get OK response
    And we get updated response
      """
      {
          "type": "text",
          "slugline": "comics",
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "_current_version": 1,
          "urgency": 1,
          "priority": 3,
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "family_id": "xyz",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          },
          "genre": [{"name": "Broadcast Script", "qcode": "Broadcast Script"}],
          "broadcast": {
            "status": "",
            "master_id": "123"
          }
      }
      """

  @auth @vocabulary
  Scenario: Create Archive Broadcast Content on a personal workspace
    Given "desks"
    """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
    """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "preformatted",
            "act": "publish",
            "_id": "publish_preformatted"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "preformatted",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    When we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get OK response
    And we get updated response
      """
      {
          "type": "preformatted",
          "slugline": "comics",
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "_current_version":1,
          "task": {
            "user": "#CONTEXT_USER_ID#"
          },
          "urgency": 1,
          "priority": 3,
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "family_id": "xyz",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          },
          "genre": [{"name": "Broadcast Script", "qcode": "Broadcast Script"}],
          "broadcast": {
            "status": "",
            "master_id": "123"
          }
      }
      """
    When we get "archive/#broadcast._id#?version=all"
    Then we get list with 1 items


  @auth
  Scenario: Cannot create Archive Broadcast Content if Broadcast Script genre is not in vocabulary.
    Given "desks"
    """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
    """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get error 400
    """
    {"_message": "Cannot find the Broadcast Script genre."}
    """

  @auth @vocabulary
  Scenario: Cannot create Archive Broadcast Content if master story is not present
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get error 404
    """
    {"_message": "Cannot find the requested item id."}
    """

  @auth @vocabulary
  Scenario: Cannot change genre for Archive Broadcast Content if master story is present
    Given "desks"
    """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
    """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get OK response
    And we get updated response
    """
    {
        "type": "text",
        "slugline": "comics",
        "state": "draft",
        "subject":[{"qcode": "17004000", "name": "Statistics"}],
        "anpa_category": [
              {"name": "Australian General News", "qcode": "a"}
        ],
        "task": {
            "user": "#CONTEXT_USER_ID#",
            "desk": "#desks._id#",
            "stage": "#desks.working_stage#"
        },
        "_current_version": 1,
        "urgency": 1,
        "priority": 3,
        "place": [{"qcode": "VIC", "name": "VIC"}],
        "family_id": "xyz",
        "dateline": {
          "source": "AAP",
          "text": "Los Angeles, Aug 11 AAP -"
        },
        "genre": [{"name": "Broadcast Script", "qcode": "Broadcast Script"}],
        "broadcast": {
          "status": "",
          "master_id": "123"
        }
    }
    """
    When we patch "archive/#broadcast._id#"
    """
    {"genre": [{"name": "Article", "qcode": "Article"}]}
    """
    Then we get error 400
    """
    {"_issues": {"validator exception": "400: Cannot change the genre for broadcast content."}}
    """


  @auth @vocabulary
  Scenario: Cannot create Archive Broadcast Content if content type is not text or preformatted
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "picture",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get error 400
    """
    {"_message": "Invalid content type."}
    """

  @auth @vocabulary
  Scenario: Cannot create Archive Broadcast Content if content state is spiked
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we spike "123"
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get error 400
    """
    {"_message": "Invalid content state."}
    """

  @auth @vocabulary
  Scenario: Cannot create Archive Broadcast Content if content state is killed
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        },
        {
            "_id": "kill_text",
            "act": "kill",
            "type": "text",
            "schema": {}
        }
      ]
      """
    And the "content_templates"
      """
      [
      {"template_name": "kill", "template_type": "kill", "is_public": true,
       "data": {"body_html": "<p>Story killed due to court case. Please remove the story from your archive.<\/p>",
                "type": "text", "abstract": "This article has been removed", "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice",
                "urgency": 1, "priority": 1,  "anpa_take_key": "KILL\/TAKEDOWN",
                "kill_header": "<p>Please kill story slugged {{ item.slugline }} ex {{ item.dateline['text'] }}.<\/p>"}
      }]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we publish "#archive._id#" with "kill" type and "killed" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{}]
    """
    Then we get error 400
    """
    {"_message": "Invalid content state."}
    """

  @auth @vocabulary
  Scenario: Create Archive Broadcast Content if content state is published
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get OK response



  @auth @vocabulary
  Scenario: Spike the broadcast content
    Given "desks"
    """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
    """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get OK response
    And we get updated response
      """
      {
          "type": "text",
          "slugline": "comics",
          "state": "draft",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "_current_version": 1,
          "urgency": 1,
          "priority": 3,
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "family_id": "xyz",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          },
          "genre": [{"name": "Broadcast Script", "qcode": "Broadcast Script"}],
          "broadcast": {
            "status": "",
            "master_id": "123"
          }
      }
      """
    When we spike "#broadcast._id#"
    Then we get OK response
    When we get "/archive/#broadcast._id#"
    Then we get existing resource
    """
    {
      "state": "spiked",
      "_id": "#broadcast._id#",
      "_current_version": 2,
      "broadcast": null
    }
    """

  @auth @vocabulary
  Scenario: Change the broadcast content status based on the actions performed in the published master story
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        },
        {
            "schema": {},
            "type": "text",
            "act": "correct",
            "_id": "correct_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "wire", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we publish "#archive._id#" with "correct" type and "corrected" state
    Then we get OK response
    When we get "/archive/#broadcast._id#"
    Then we get existing resource
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "Master Story Corrected",
        "master_id": "123"
      }
    }
    """
    And broadcast "rewrite_id" has value "none"
    When we rewrite "123"
      """
      {"desk_id": "#desks._id#"}
      """
    Then we get OK response
    And we get "/archive/#broadcast._id#" and match
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "Master Story Re-written",
        "master_id": "123",
        "rewrite_id": "#REWRITE_ID#"
      }
    }
    """

  @auth @vocabulary
  Scenario: Spike the re-write and it should remove the reference from broadcast
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        }
      ]
      """
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast"
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we rewrite "123"
      """
      {"desk_id": "#desks._id#"}
      """
    Then we get OK response
    And we get "/archive/#broadcast._id#" and match
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "Master Story Re-written",
        "master_id": "123",
        "rewrite_id": "#REWRITE_ID#"
      }
    }
    """
    When we spike "#REWRITE_ID#"
    Then we get OK response
    When we get "/archive/#broadcast._id#"
    Then we get existing resource
    """
    {
      "state": "draft",
      "_id": "#broadcast._id#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    And broadcast "rewrite_id" has value "none"



  @auth @vocabulary
  Scenario: If Master Story is kill then kill published broadcast content and spike unpublished broadcast content.
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        },
        {
            "schema": {},
            "type": "text",
            "act": "kill",
            "_id": "kill_text"
        }
      ]
      """
    When we post to "content_templates"
      """

          {
            "data": {
              "body_html": "<p>This is test story.<\/p>",
              "type": "text",
              "abstract": "This article has been removed",
              "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice",
              "urgency": 1, "priority": 1,
              "anpa_take_key": "KILL\/TAKEDOWN"
            },
            "template_name": "kill",
            "template_type": "kill",
            "is_public": true
          }
      """
    Then we get new resource
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_ONE" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we patch "archive/#BROADCAST_ONE#"
    """
    {
      "body_html": "TEST",
      "headline": "TEST",
      "slugline": "broadcast",
      "dateline": {
        "source": "AAP",
        "text": "New York, Aug 11 AAP -"
      }
    }
    """
    Then we get OK response
    When we publish "#BROADCAST_ONE#" with "publish" type and "published" state
    Then we get updated response
    """
      {
        "_id": "#BROADCAST_ONE#",
        "_current_version": 3,
        "state": "published",
        "slugline": "broadcast",
        "dateline": {
          "source": "AAP",
          "text": "New York, Aug 11 AAP -"
        }
      }
    """
    When we post to "archive/123/broadcast" with "BROADCAST_TWO" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_TWO#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    Then we get OK response
    When we publish "123" with "kill" type and "killed" state
    """
    {"body_html": "<p>This is kill body.<\/p>"}
    """
    Then we get OK response
    And we get "/archive/123" and match
    """
    {
      "state": "killed",
      "_id": "123"
    }
    """
    And we get text "Please kill story slugged comics headlined headline exLos Angeles" in response field "body_html"
    And we get text "This is kill body" in response field "body_html"
    When we get "/archive/#BROADCAST_ONE#"
    Then we get existing resource
    """
    {
      "state": "killed",
      "abstract": "This article has been removed",
      "anpa_take_key": "KILL\/TAKEDOWN",
      "urgency": 1, "priority": 1,
      "_current_version": 4,
      "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice"
    }
    """
    And we get text "Please kill story slugged broadcast headlined TEST exNew York" in response field "body_html"
    And we get text "This is kill body" in response field "body_html"
    And we get "/archive/#BROADCAST_TWO#" and match
    """
    {
      "state": "spiked"
    }
    """

  @auth @vocabulary
  Scenario: Master Story is killed and broadcast content in packaged in a unpublished package.
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        },
        {
            "schema": {},
            "type": "text",
            "act": "kill",
            "_id": "kill_text"
        },
        {
            "schema": {},
            "type": "composite",
            "act": "publish",
            "_id": "publish_composite"
        },
        {
            "schema": {},
            "type": "composite",
            "act": "kill",
            "_id": "kill_composite"
        }
      ]
      """
    When we post to "content_templates"
      """

          {
            "data": {
              "body_html": "<p>Please kill this story.<\/p>",
              "type": "text",
              "abstract": "This article has been removed",
              "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice",
              "urgency": 1, "priority": 1,
              "anpa_take_key": "KILL\/TAKEDOWN"
            },
            "template_name": "kill",
            "template_type": "kill",
            "is_public": true
          }
      """
    Then we get new resource
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_ONE" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we patch "archive/#BROADCAST_ONE#"
    """
    {
      "body_html": "TEST",
      "headline": "TEST",
      "dateline": {
            "source": "AAP",
            "text": "New York, Aug 11 AAP -"
      }
    }
    """
    Then we get updated response
    """
    {
      "state": "in_progress",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 2,
      "broadcast": {
        "status": "",
        "master_id": "123"
      },
      "body_html": "TEST", "headline": "TEST"
    }
    """
    When we publish "#BROADCAST_ONE#" with "publish" type and "published" state
    Then we get updated response
    """
    {
      "state": "published",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 3,
      "broadcast": {
        "status": "",
        "master_id": "123"
      },
      "body_html": "TEST", "headline": "TEST"
    }
    """
    When we post to "archive/123/broadcast" with "BROADCAST_TWO" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_TWO#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    Then we get OK response
    When we post to "archive" with "PACKAGE" and success
    """
          [{
              "groups": [
              {
                  "id": "root",
                  "refs": [
                      {
                          "idRef": "main"
                      }
                  ],
                  "role": "grpRole:NEP"
              },
              {
                  "id": "main",
                  "refs": [
                      {
                          "renditions": {},
                          "slugline": "Boat",
                          "guid": "#BROADCAST_ONE#",
                          "headline": "item-1 headline",
                          "location": "archive",
                          "type": "text",
                          "itemClass": "icls:text",
                          "residRef": "#BROADCAST_ONE#"
                      }
                  ],
                  "role": "grpRole:main"
              }
          ],
              "task": {
                  "user": "#CONTEXT_USER_ID#",
                  "status": "todo",
                  "stage": "#desks.incoming_stage#",
                  "desk": "#desks._id#"
              },
              "guid" : "compositeitem",
              "state" : "submitted",
              "type" : "composite"
          }]
    """
    Then we get OK response
    When we publish "123" with "kill" type and "killed" state
    """
    {"body_html": "This is kill body"}
    """
    Then we get OK response
    And we get "/archive/123" and match
    """
    {
      "state": "killed",
      "_id": "123"
    }
    """
    When we get "/archive/#BROADCAST_ONE#"
    Then we get existing resource
    """
    {
      "state": "killed",
      "abstract": "This article has been removed",
      "anpa_take_key": "KILL\/TAKEDOWN",
      "urgency": 1, "priority": 1, "_current_version": 4,
      "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice"
    }
    """
    And we get text "Please kill story slugged comics headlined TEST exNew York" in response field "body_html"
    And we get text "This is kill body" in response field "body_html"
    And we get "/archive/#BROADCAST_TWO#" and match
    """
    {
      "state": "spiked",
      "_current_version": 2
    }
    """
    And we get "/archive/#PACKAGE#" and match
    """
    {
      "state": "in_progress",
      "groups": [
        {
            "id": "root",
            "refs": [
                {
                    "idRef": "main"
                }
            ],
            "role": "grpRole:NEP"
        },
        {
            "id": "main",
            "refs": [],
            "role": "grpRole:main"
        }
      ]
    }
    """

  @auth @vocabulary
  Scenario: Master Story is killed and broadcast content in packaged in a published package.
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {"schema": {}, "type": "text", "act": "publish", "_id": "publish_text"},
        {"schema": {}, "type": "text", "act": "kill", "_id": "kill_text"},
        {"schema": {}, "type": "text", "act": "correct", "_id": "correct_text"},
        {"schema": {}, "type": "composite", "act": "publish", "_id": "publish_composite"},
        {"schema": {}, "type": "composite", "act": "kill", "_id": "kill_composite"},
        {"schema": {}, "type": "composite", "act": "correct", "_id": "correct_composite"}
      ]
      """
    When we post to "content_templates"
      """
        {
          "data": {
            "body_html": "<p>This is  killed.<\/p>",
            "type": "text",
            "abstract": "This article has been removed",
            "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice",
            "urgency": 1, "priority": 1,
            "anpa_take_key": "KILL\/TAKEDOWN"
          },
          "template_name": "kill",
          "template_type": "kill",
          "is_public": true
        }
      """
    Then we get new resource
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_ONE" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we patch "archive/#BROADCAST_ONE#"
    """
    {"body_html": "TEST", "headline": "TEST"}
    """
    Then we get OK response
    When we publish "#BROADCAST_ONE#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_TWO" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_TWO#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    Then we get OK response
    When we post to "archive" with "PACKAGE" and success
    """
          [{
              "groups": [
              {
                  "id": "root",
                  "refs": [
                      {
                          "idRef": "main"
                      }
                  ],
                  "role": "grpRole:NEP"
              },
              {
                  "id": "main",
                  "refs": [
                      {
                          "renditions": {},
                          "slugline": "Boat",
                          "guid": "#BROADCAST_ONE#",
                          "headline": "item-1 headline",
                          "location": "archive",
                          "type": "text",
                          "itemClass": "icls:text",
                          "residRef": "#BROADCAST_ONE#"
                      }
                  ],
                  "role": "grpRole:main"
              }
          ],
              "task": {
                  "user": "#CONTEXT_USER_ID#",
                  "status": "todo",
                  "stage": "#desks.incoming_stage#",
                  "desk": "#desks._id#"
              },
              "guid" : "compositeitem",
              "state" : "submitted",
              "type" : "composite"
          }]
    """
    Then we get OK response
    When we publish "#PACKAGE#" with "publish" type and "published" state
    Then we get OK response
    When we publish "123" with "kill" type and "killed" state
    Then we get OK response
    And we get "/archive/123" and match
    """
    {
      "state": "killed",
      "_id": "123"
    }
    """
    And we get "/archive/#BROADCAST_ONE#" and match
    """
    {
      "state": "killed"
    }
    """
    And we get "/archive/#BROADCAST_TWO#" and match
    """
    {
      "state": "spiked"
    }
    """
    And we get "/archive/#PACKAGE#" and match
    """
    {
      "state": "killed",
      "groups": [
        {
            "id": "root",
            "refs": [
                {
                    "idRef": "main"
                }
            ],
            "role": "grpRole:NEP"
        },
        {
            "id": "main",
            "refs": [],
            "role": "grpRole:main"
        }
      ]
    }
    """

  @auth @vocabulary
  Scenario: Master Story is killed and broadcast content in packaged in a published package with extra content.
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {"schema": {}, "type": "text", "act": "publish", "_id": "publish_text"},
        {"schema": {}, "type": "text", "act": "kill", "_id": "kill_text"},
        {"schema": {}, "type": "text", "act": "correct", "_id": "correct_text"},
        {"schema": {}, "type": "composite", "act": "publish", "_id": "publish_composite"},
        {"schema": {}, "type": "composite", "act": "kill", "_id": "kill_composite"},
        {"schema": {}, "type": "composite", "act": "correct", "_id": "correct_composite"}
      ]
      """
    When we post to "content_templates"
      """
        {
          "data": {
            "body_html": "<p>Please kill the story.<\/p>",
            "type": "text",
            "abstract": "This article has been removed",
            "headline": "Kill\/Takedown notice ~~~ Kill\/Takedown notice",
            "urgency": 1, "priority": 1,
            "anpa_take_key": "KILL\/TAKEDOWN"
          },
          "template_name": "kill",
          "template_type": "kill",
          "is_public": true
        }
      """
    Then we get new resource
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      },
      {
          "guid": "456",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "123" with "publish" type and "published" state
    Then we get OK response
    When we publish "456" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_ONE" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we patch "archive/#BROADCAST_ONE#"
    """
    {"body_html": "TEST", "headline": "TEST"}
    """
    Then we get OK response
    When we publish "#BROADCAST_ONE#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_TWO" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_TWO#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    Then we get OK response
    When we post to "archive" with "PACKAGE" and success
    """
          [{
              "groups": [
              {
                  "id": "root",
                  "refs": [
                      {
                          "idRef": "main"
                      }
                  ],
                  "role": "grpRole:NEP"
              },
              {
                  "id": "main",
                  "refs": [
                      {
                          "renditions": {},
                          "slugline": "comics",
                          "guid": "#BROADCAST_ONE#",
                          "headline": "headline",
                          "location": "archive",
                          "type": "text",
                          "itemClass": "icls:text",
                          "residRef": "#BROADCAST_ONE#"
                      },
                      {
                          "renditions": {},
                          "slugline": "comics",
                          "guid": "456",
                          "headline": "headline",
                          "location": "archive",
                          "type": "text",
                          "itemClass": "icls:text",
                          "residRef": "456"
                      }
                  ],
                  "role": "grpRole:main"
              }
          ],
              "task": {
                  "user": "#CONTEXT_USER_ID#",
                  "status": "todo",
                  "stage": "#desks.incoming_stage#",
                  "desk": "#desks._id#"
              },
              "guid" : "compositeitem",
              "state" : "submitted",
              "type" : "composite",
              "headline": "package headline",
              "abstract": "package abstract"
          }]
    """
    Then we get OK response
    When we publish "#PACKAGE#" with "publish" type and "published" state
    Then we get OK response
    When we publish "123" with "kill" type and "killed" state
    Then we get OK response
    And we get "/archive/123" and match
    """
    {
      "state": "killed",
      "_id": "123"
    }
    """
    And we get "/archive/#BROADCAST_ONE#" and match
    """
    {
      "state": "killed"
    }
    """
    And we get "/archive/#BROADCAST_TWO#" and match
    """
    {
      "state": "spiked"
    }
    """
    And we get "/archive/#PACKAGE#" and match
    """
    {
      "state": "corrected",
      "groups": [
        {
            "id": "root",
            "refs": [
                {
                    "idRef": "main"
                }
            ],
            "role": "grpRole:NEP"
        },
        {
            "id": "main",
            "refs": [
                      {
                          "renditions": {},
                          "slugline": "comics",
                          "guid": "456",
                          "headline": "headline",
                          "location": "archive",
                          "type": "text",
                          "itemClass": "icls:text",
                          "residRef": "456"
                      }
            ],
            "role": "grpRole:main"
        }
      ]
    }
    """

  @auth @vocabulary
  Scenario: If Master Story is taken down then recall published broadcast content and spike unpublished broadcast content.
    Given "desks"
      """
      [{"name": "Sports", "members": [{"user": "#CONTEXT_USER_ID#"}]}]
      """
    And the "validators"
      """
      [
        {
            "schema": {},
            "type": "text",
            "act": "publish",
            "_id": "publish_text"
        },
        {
            "schema": {},
            "type": "text",
            "act": "kill",
            "_id": "kill_text"
        }
      ]
      """
    When we post to "content_templates"
      """

          {
            "data": {
              "body_html": "<p>This is test story.<\/p>",
              "type": "text",
              "abstract": "This article has been removed",
              "headline": "Takedown notice ~~~ Takedown notice",
              "urgency": 1, "priority": 1,
              "anpa_take_key": "TAKEDOWN"
            },
            "template_name": "takedown",
            "template_type": "kill",
            "is_public": true
          }
      """
    Then we get new resource
    When we post to "archive"
      """
      [{
          "guid": "123",
          "type": "text",
          "headline": "headline",
          "slugline": "comics",
          "anpa_take_key": "take key",
          "anpa_category": [
                {"name": "Australian General News", "qcode": "a"}
          ],
          "state": "in_progress",
          "subject":[{"qcode": "17004000", "name": "Statistics"}],
          "task": {
              "user": "#CONTEXT_USER_ID#",
              "desk": "#desks._id#",
              "stage": "#desks.working_stage#"
          },
          "genre": [{"name": "Article", "qcode": "Article"}],
          "urgency": 1,
          "priority": 3,
          "family_id": "xyz",
          "place": [{"qcode": "VIC", "name": "VIC"}],
          "body_html": "Take-1",
          "dateline": {
            "source": "AAP",
            "text": "Los Angeles, Aug 11 AAP -"
          }
      }]
      """
    Then we get OK response
    When we post to "/products" with success
      """
      {
        "name":"prod-1","codes":"abc,xyz", "product_type": "both"
      }
      """
    And we post to "/subscribers" with success
      """
      {
        "name":"Channel 3","media_type":"media", "subscriber_type": "digital", "sequence_num_settings":{"min" : 1, "max" : 10}, "email": "test@test.com",
        "products": ["#products._id#"],
        "destinations":[{"name":"Test","format": "nitf", "delivery_type":"email","config":{"recipients":"test@test.com"}}]
      }
      """
    And we publish "#archive._id#" with "publish" type and "published" state
    Then we get OK response
    When we post to "archive/123/broadcast" with "BROADCAST_ONE" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_ONE#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    When we patch "archive/#BROADCAST_ONE#"
    """
    {
      "body_html": "TEST",
      "headline": "TEST",
      "slugline": "broadcast",
      "dateline": {
        "source": "AAP",
        "text": "New York, Aug 11 AAP -"
      }
    }
    """
    Then we get OK response
    When we publish "#BROADCAST_ONE#" with "publish" type and "published" state
    Then we get updated response
    """
      {
        "_id": "#BROADCAST_ONE#",
        "_current_version": 3,
        "state": "published",
        "slugline": "broadcast",
        "dateline": {
          "source": "AAP",
          "text": "New York, Aug 11 AAP -"
        }
      }
    """
    When we post to "archive/123/broadcast" with "BROADCAST_TWO" and success
    """
    [{"desk": "#desks._id#"}]
    """
    Then we get updated response
    """
    {
      "state": "draft",
      "_id": "#BROADCAST_TWO#",
      "_current_version": 1,
      "broadcast": {
        "status": "",
        "master_id": "123"
      }
    }
    """
    Then we get OK response
    When we publish "123" with "takedown" type and "recalled" state
    """
    {"body_html": "<p>Recalled body.<\/p>"}
    """
    Then we get OK response
    And we get "/archive/123" and match
    """
    {
      "state": "recalled",
      "_id": "123"
    }
    """
    And we get text "Please takedown story slugged comics headlined headline exLos Angeles" in response field "body_html"
    And we get text "Recalled body" in response field "body_html"
    When we get "/archive/#BROADCAST_ONE#"
    Then we get existing resource
    """
    {
      "state": "recalled",
      "abstract": "This article has been removed",
      "anpa_take_key": "TAKEDOWN",
      "urgency": 1, "priority": 1,
      "_current_version": 4,
      "headline": "Takedown notice ~~~ Takedown notice"
    }
    """
    And we get text "Please takedown story slugged broadcast headlined TEST exNew York" in response field "body_html"
    And we get text "Recalled body" in response field "body_html"
    And we get "/archive/#BROADCAST_TWO#" and match
    """
    {
      "state": "spiked"
    }
    """