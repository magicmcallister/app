import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/model.dart';

var headers = {
  'Notion-Version': '2021-08-16',
  'Content-Type': 'application/json',
  'Authorization': null
};

var data = {
  "filter": {
    "property": "date",
    "date": {"is_empty": true}
  }
};

var body = json.encode(data);

var queryDatabaseUrl =
    "https://api.notion.com/v1/databases/3afff078e210449d9fc9d49da2d3711d/query";

var postTaskUrl = "https://api.notion.com/v1/pages/";

var newTaskData = {
  "parent": {"database_id": "3afff078e210449d9fc9d49da2d3711d"},
  "properties": {
    "name": {
      "title": [
        {
          "text": {"content": "Test title"}
        }
      ]
    },
    "description": {
      "rich_text": [
        {
          "type": "text",
          "text": {"content": "Test description"}
        }
      ]
    },
  }
};
