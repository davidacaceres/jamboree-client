// To parse this JSON data, do
//
//     final version = versionFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Version {
  final String description;
  final double content;
  final double location;

  Version({
    @required this.description,
    @required this.content,
    @required this.location,
  });

  factory Version.fromJson(String str) => Version.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Version.fromMap(Map<String, dynamic> json) => Version(
    description: json["description"],
    content: json["content"],
    location: json["location"],
  );

  Map<String, dynamic> toMap() => {
    "description": description,
    "content": content,
    "location": location,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Version &&
              runtimeType == other.runtimeType &&
              description == other.description;

  @override
  int get hashCode => description.hashCode;


}
