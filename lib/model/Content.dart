// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

List<Content> contentFromJson(String str) =>
    List<Content>.from(json.decode(str).map((x) => Content.fromMap(x)));

String contentToJson(List<Content> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Content {
  String id;
  int order;
  String title;
  String titleList;
  String description;
  String content;
  String imageUrl;

  Content({
    this.id,
    this.order,
    this.title,
    this.titleList,
    this.description,
    this.content,
    this.imageUrl,
  });

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        order: json["content"],
        title: json["title"],
        titleList: json["title_list"],
        description: json["description"],
        content: json["content"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "title": title,
        "title_list": titleList,
        "description": description,
        "content": content,
        "image_url": imageUrl,
      };
}
