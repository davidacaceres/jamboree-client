

import 'dart:convert';

class TimeLineConf {
  final DateTime date;
  final List<int> textColor;
  final int fontSize;
  final String fontFamily;
  final List<Line> line;

  TimeLineConf({
    this.date,
    this.textColor,
    this.fontSize,
    this.fontFamily,
    this.line,
  });

  factory TimeLineConf.fromJson(String str) => TimeLineConf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TimeLineConf.fromMap(Map<String, dynamic> json) => TimeLineConf(
    date: DateTime.parse(json["date"]),
    textColor: List<int>.from(json["textColor"].map((x) => x)),
    fontSize: json["fontSize"],
    fontFamily: json["fontFamily"],
    line: List<Line>.from(json["line"].map((x) => Line.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "textColor": List<dynamic>.from(textColor.map((x) => x)),
    "fontSize": fontSize,
    "fontFamily": fontFamily,
    "line": List<dynamic>.from(line.map((x) => x.toMap())),
  };
}

class Line {
  final List<int> backgroundColor;
  final String image;
  final String title;
  final List<int> titleColor;
  final double titleFontSize;
  final String titleFontFamiy;
  final String time;
  final List<int> timeColor;
  final double timeFontSize;
  final String timeFontFamily;

  Line({
    this.backgroundColor,
    this.image,
    this.title,
    this.titleColor,
    this.titleFontSize,
    this.titleFontFamiy,
    this.time,
    this.timeColor,
    this.timeFontSize,
    this.timeFontFamily,
  });

  factory Line.fromJson(String str) => Line.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Line.fromMap(Map<String, dynamic> json) => Line(
    backgroundColor: json["backgroundColor"] == null ? null : List<int>.from(json["backgroundColor"].map((x) => x)),
    image: json["image"],
    title: json["title"],
    titleColor: json["titleColor"] == null ? null : List<int>.from(json["titleColor"].map((x) => x)),
    titleFontSize: json["titleFontSize"] == null ? null : json["titleFontSize"].toDouble(),
    titleFontFamiy: json["titleFontFamiy"] == null ? null : json["titleFontFamiy"],
    time: json["time"],
    timeColor: json["timeColor"] == null ? null : List<int>.from(json["timeColor"].map((x) => x)),
    timeFontSize: json["timeFontSize"] == null ? null : json["timeFontSize"].toDouble(),
    timeFontFamily: json["timeFontFamily"] == null ? null : json["timeFontFamily"],
  );

  Map<String, dynamic> toMap() => {
    "backgroundColor": backgroundColor == null ? null : List<dynamic>.from(backgroundColor.map((x) => x)),
    "image": image,
    "title": title,
    "titleColor": titleColor == null ? null : List<dynamic>.from(titleColor.map((x) => x)),
    "titleFontSize": titleFontSize == null ? null : titleFontSize,
    "titleFontFamiy": titleFontFamiy == null ? null : titleFontFamiy,
    "time": time,
    "timeColor": timeColor == null ? null : List<dynamic>.from(timeColor.map((x) => x)),
    "timeFontSize": timeFontSize == null ? null : timeFontSize,
    "timeFontFamily": timeFontFamily == null ? null : timeFontFamily,
  };
}
