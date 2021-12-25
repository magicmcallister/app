import 'package:flutter/rendering.dart';

class Database {
  final String object;
  final String id;
  final String? cover;
  final String? icon;
  final String created_time;
  final String last_edited_time;
  final List? title;
  final Map? properties;
  final Map parent;
  final String url;

  Database(
      {required this.object,
      required this.id,
      required this.cover,
      required this.icon,
      required this.created_time,
      required this.last_edited_time,
      required this.title,
      required this.properties,
      required this.parent,
      required this.url});

  factory Database.fromJson(Map<String, dynamic> json) {
    return Database(
        object: json["object"],
        id: json["id"],
        cover: json["cover"],
        icon: json["icon"],
        created_time: json["created_time"],
        last_edited_time: json["last_edited_time"],
        title: json["title"],
        properties: json["properties"],
        parent: json["parent"],
        url: json["url"]);
  }
}
