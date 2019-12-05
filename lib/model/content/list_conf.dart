import 'dart:convert';

import 'package:flutter/widgets.dart';

class ListConf {
  final List<int> textColor;
  final double fontSize;
  final String fontFamily;
  final List<Item> items;
  final List<int> backgroundColor;
  final double heigth;

  ListConf({
    this.textColor,
    this.fontSize,
    this.fontFamily,
    this.items,
    this.backgroundColor,
    this.heigth
  });

  factory ListConf.fromJson(String str) => ListConf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListConf.fromMap(Map<String, dynamic> json) => ListConf(
    textColor: List<int>.from(json["textColor"].map((x) => x)),
    fontSize: json["fontSize"],
    fontFamily: json["fontFamily"],
    items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
    backgroundColor: List<int>.from(json["backgroundColor"].map((x) => x)),
    heigth: json["heigth"],

  );

  Map<String, dynamic> toMap() => {
    "textColor": List<dynamic>.from(textColor.map((x) => x)),
    "fontSize": fontSize,
    "fontFamily": fontFamily,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
    "backgroundColor": List<dynamic>.from(backgroundColor.map((x) => x)),
    "heigth": heigth,

  };
}

class Item {
  final List<int> backgroundColor;
  final String image;
  final String title;
  final List<int> titleColor;
  final double titleFontSize;
  final String titleFontFamiy;
  final String subtitle;
  final List<int> subtitleColor;
  final double subtitleFontSize;
  final String subtitleFontFamiy;

  Item({
    this.backgroundColor,
    @required this.image,
    @required this.title,
    this.titleColor,
    this.titleFontSize,
    this.titleFontFamiy,
    this.subtitle,
    this.subtitleColor,
    this.subtitleFontSize,
    this.subtitleFontFamiy,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    backgroundColor: json["backgroundColor"] == null ? null : List<int>.from(json["backgroundColor"].map((x) => x)),
    image: json["image"],
    title: json["title"],
    titleColor: json["titleColor"] == null ? null : List<int>.from(json["titleColor"].map((x) => x)),
    titleFontSize: json["titleFontSize"] == null ? null : json["titleFontSize"].toDouble(),
    titleFontFamiy: json["titleFontFamiy"] == null ? null : json["titleFontFamiy"],
    subtitle: json["subtitle"],
    subtitleColor: json["subtitleColor"] == null ? null : List<int>.from(json["subtitleColor"].map((x) => x)),
    subtitleFontSize: json["subtitleFontSize"] == null ? null : json["subtitleFontSize"].toDouble(),
    subtitleFontFamiy: json["subtitleFontFamiy"] == null ? null : json["subtitleFontFamiy"],
  );

  Map<String, dynamic> toMap() => {
    "backgroundColor": backgroundColor == null ? null : List<dynamic>.from(backgroundColor.map((x) => x)),
    "image": image,
    "title": title,
    "titleColor": titleColor == null ? null : List<dynamic>.from(titleColor.map((x) => x)),
    "titleFontSize": titleFontSize == null ? null : titleFontSize,
    "titleFontFamiy": titleFontFamiy == null ? null : titleFontFamiy,
    "subtitle": subtitle,
    "subtitleColor": subtitleColor == null ? null : List<dynamic>.from(subtitleColor.map((x) => x)),
    "subtitleFontSize": subtitleFontSize == null ? null : subtitleFontSize,
    "subtitleFontFamiy": subtitleFontFamiy == null ? null : subtitleFontFamiy,
  };
}