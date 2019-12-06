

import 'dart:convert';


class TimeLineConf {
  final List<int> textColor;
  final double fontSize;
  final String fontFamily;
  final List<Line> lines;
  final String linePosition;
  final List<int> lineColor;
  final List<int> backgroundColor;


  TimeLineConf({
    this.textColor,
    this.fontSize,
    this.fontFamily,
    this.lines,
    this.linePosition,
    this.lineColor,
    this.backgroundColor
  });

  factory TimeLineConf.fromJson(String str) => TimeLineConf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TimeLineConf.fromMap(Map<String, dynamic> json) => TimeLineConf(
    textColor: List<int>.from(json["textColor"].map((x) => x)),
    fontSize: json["fontSize"],
    fontFamily: json["fontFamily"],
    lines: (json["lines"]==null?null: List<Line>.from(json["lines"].map((x) => Line.fromMap(x)))),
    linePosition: (json["linePosition"]==null?null:json["linePosition"]),
    lineColor: (json["lineColor"]==null?null:List<int>.from(json["lineColor"].map((x) => x))),
    backgroundColor: (json["backgroundColor"]==null?null:List<int>.from(json["backgroundColor"].map((x) => x))),

  );

  Map<String, dynamic> toMap() => {
    "textColor": List<dynamic>.from(textColor.map((x) => x)),
    "fontSize": fontSize,
    "fontFamily": fontFamily,
    "lines": (lines==null?null:List<dynamic>.from(lines.map((x) => x.toMap()))),
    "linePosition":linePosition,
    "lineColor": (lineColor==null?null:List<dynamic>.from(lineColor.map((x) => x))),
    "backgroundColor": (backgroundColor==null?null:List<dynamic>.from(backgroundColor.map((x) => x))),


  };
}

class Line {
  final List<int> backgroundColor;
  final String image;
  final String title;
  final List<int> titleColor;
  final double titleFontSize;
  final String titleFontFamily;
  final String time;
  final List<int> timeColor;
  final double timeFontSize;
  final String timeFontFamily;
  final String position;
  final int materialIcon;

  Line({
    this.backgroundColor,
    this.image,
    this.title,
    this.titleColor,
    this.titleFontSize,
    this.titleFontFamily,
    this.time,
    this.timeColor,
    this.timeFontSize,
    this.timeFontFamily,
    this.position,
    this.materialIcon,
  });

  factory Line.fromJson(String str) => Line.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Line.fromMap(Map<String, dynamic> json) => Line(
    backgroundColor: json["backgroundColor"] == null ? null : List<int>.from(json["backgroundColor"].map((x) => x)),
    image: json["image"],
    title: json["title"],
    titleColor: json["titleColor"] == null ? null : List<int>.from(json["titleColor"].map((x) => x)),
    titleFontSize: json["titleFontSize"] == null ? null : json["titleFontSize"].toDouble(),
    titleFontFamily: json["titleFontFamily"] == null ? null : json["titleFontFamily"],
    time: json["time"],
    timeColor: json["timeColor"] == null ? null : List<int>.from(json["timeColor"].map((x) => x)),
    timeFontSize: json["timeFontSize"] == null ? null : json["timeFontSize"].toDouble(),
    timeFontFamily: json["timeFontFamily"] == null ? null : json["timeFontFamily"],
    position: json["position"] == null ? null : json["position"],
    materialIcon: json["materialIcon"] == null ? null : json["materialIcon"],

  );

  Map<String, dynamic> toMap() => {
    "backgroundColor": backgroundColor == null ? null : List<dynamic>.from(backgroundColor.map((x) => x)),
    "image": image,
    "title": title,
    "titleColor": titleColor == null ? null : List<dynamic>.from(titleColor.map((x) => x)),
    "titleFontSize": titleFontSize == null ? null : titleFontSize,
    "titleFontFamily": titleFontFamily == null ? null : titleFontFamily,
    "time": time,
    "timeColor": timeColor == null ? null : List<dynamic>.from(timeColor.map((x) => x)),
    "timeFontSize": timeFontSize == null ? null : timeFontSize,
    "timeFontFamily": timeFontFamily == null ? null : timeFontFamily,
    "position": position == null ? null : position,
    "materialIcon": position == null ? null : materialIcon,

  };
}
