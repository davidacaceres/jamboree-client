import 'package:Pasaporte_2020/model/content/content_element.dart';

class Display {
  String shortTitle;
  List<ContentElement> content;
  List<Child> childs;

  Display({
    this.shortTitle,
    this.content,
    this.childs,
  });

  factory Display.fromMap(Map<String, dynamic> json) => Display(
    shortTitle: json["short_title"],
    content: List<ContentElement>.from(
        json["content"].map((x) => ContentElement.fromMap(x))),
    childs: json["childs"] == null
        ? null
        : List<Child>.from(json["childs"].map((x) => Child.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "short_title": shortTitle,
    "content": List<dynamic>.from(content.map((x) => x.toMap())),
    "childs": childs == null
        ? null
        : List<dynamic>.from(childs.map((x) => x.toMap())),
  };
}

class Child {
  String id;
  int order;
  String title;
  List<int> backgroundColor;
  List<int> textColor;
  String image;

  Child(
      {this.id, this.order, this.title, this.backgroundColor, this.textColor,this.image});

  factory Child.fromMap(Map<String, dynamic> json) => Child(
    id: json["id"],
    order: json["order"],
    title: json["title"],
    backgroundColor: json["backgroundColor"] == null
        ? null
        : List<int>.from(json["backgroundColor"].map((x) => x)),
    textColor: json["textColor"] == null
        ? null
        : List<int>.from(json["textColor"].map((x) => x)),
    image: json["image"],

  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "order": order,
    "title": title,
    "backgroundColor": backgroundColor == null
        ? null
        : List<dynamic>.from(backgroundColor.map((x) => x)),
    "textColor": textColor == null
        ? null
        : List<dynamic>.from(textColor.map((x) => x)),
    "image": image,
  };
}