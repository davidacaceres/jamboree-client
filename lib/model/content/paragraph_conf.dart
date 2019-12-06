

class ParagraphConf {
  List<int> textColor;
  List<int> backgroundColor;
  String data;
  double fontSize;
  String font;

  ParagraphConf(
      {this.textColor,
        this.backgroundColor,
        this.data,
        this.font,
        this.fontSize});

  factory ParagraphConf.fromMap(Map<String, dynamic> json) => ParagraphConf(
    textColor: json["text_color"] == null
        ? null
        : List<int>.from(json["text_color"].map((x) => x)),
    backgroundColor: json["background_color"] == null
        ? null
        : List<int>.from(json["background_color"].map((x) => x)),
    data: json["data"],
    fontSize: json["fontSize"] == null ? 0.0 : json["fontSize"],
    font: json["font"],
  );

  Map<String, dynamic> toMap() => {
    "text_color": textColor == null
        ? null
        : List<dynamic>.from(textColor.map((x) => x)),
    "background_color": backgroundColor == null
        ? null
        : List<dynamic>.from(backgroundColor.map((x) => x)),
    "data": data,
    "fontSize": fontSize,
    "font": font,
  };
}