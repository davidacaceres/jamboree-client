// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

import 'package:Pasaporte_2020/model/content/display.dart';

Content contentFromJson(String str) => Content.fromMap(json.decode(str));

String contentToJson(Content data) => json.encode(data.toMap());

class Content {
  String id;
  int order;
  String title;
  List<int> titleColor;
  String titleList;
  String image;
  bool root;
  List<int> backgroundPage;
  List<Display> display;
  String search;
  String font;
  double fontSize;
  List<int> tabPrimaryColor;
  List<int> tabSecondaryColor;
  List<int> tabTextColor;

  Content(
      {this.id,
      this.order,
      this.title,
      this.titleList,
      this.image,
      this.backgroundPage,
      this.display,
      this.root,
      this.search,
      this.titleColor,
      this.font,
      this.fontSize,
      this.tabPrimaryColor,
      this.tabSecondaryColor,
      this.tabTextColor});

  factory Content.fromMap(Map<String, dynamic> json) => Content(
        id: json["id"],
        order: json["order"],
        title: json["title"],
        titleList: json["titleList"] == null ? null : json["titleList"],
        image: json["image"],
        root: json["root"] == null ? false : json["root"],
        backgroundPage: List<int>.from(json["background_page"].map((x) => x)),
        display:
            List<Display>.from(json["display"].map((x) => Display.fromMap(x))),
        search: json["search"] == null ? null : json["search"],
        titleColor: json["titleColor"] == null
            ? null
            : List<int>.from(json["titleColor"].map((x) => x)),
        font: json["font"],
        fontSize: json["fontSize"],
        tabPrimaryColor: json["tabPrimaryColor"] == null
            ? null
            : List<int>.from(json["tabPrimaryColor"].map((x) => x)),
        tabSecondaryColor: json["tabSecondaryColor"] == null
            ? null
            : List<int>.from(json["tabSecondaryColor"].map((x) => x)),
        tabTextColor: json["tabTextColor"] == null
            ? null
            : List<int>.from(json["tabTextColor"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order": order,
        "title": title,
        "titleList": titleList,
        "image": image,
        "background_page": backgroundPage == null
            ? null
            : List<dynamic>.from(backgroundPage.map((x) => x)),
        "display": List<dynamic>.from(display.map((x) => x.toMap())),
        "root": root,
        "search": search,
        "titleColor": titleColor == null
            ? null
            : List<dynamic>.from(titleColor.map((x) => x)),
        "font": font,
        "fontSize": fontSize,
        "tabPrimaryColor": tabPrimaryColor == null
            ? null
            : List<dynamic>.from(tabPrimaryColor.map((x) => x)),
        "tabSecondaryColor": tabSecondaryColor == null
            ? null
            : List<dynamic>.from(tabSecondaryColor.map((x) => x)),
        "tabTextColor": tabTextColor == null
            ? null
            : List<dynamic>.from(tabTextColor.map((x) => x)),
      };
}
