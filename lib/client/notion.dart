import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

var headers = {
  'Notion-Version': '2021-08-16',
  'Content-Type': 'application/json',
  'Authorization': dotenv.get("NOTION_API_TOKEN")
};

var data = {
  "filter": {
    "property": "date",
    "date": {"is_empty": true}
  }
};

var body = json.encode(data);

var queryDatabaseUrl = dotenv.get("NOTION_API_URL") +
    "databases/" +
    dotenv.get("NOTION_TASK_DATABASE_ID") +
    "/query";

var postTaskUrl = dotenv.get("NOTION_API_URL") + "pages/";
