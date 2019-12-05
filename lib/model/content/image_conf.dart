
class ImageConf {
  String source;
  String align;
  List<int> backgroundColor;

  ImageConf({
    this.source,
    this.align,
    this.backgroundColor,
  });

  factory ImageConf.fromMap(Map<String, dynamic> json) => ImageConf(
    source: json["source"],
    align: json["align"],
    backgroundColor: json["background_color"] == null
        ? null
        : List<int>.from(json["background_color"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "source": source,
    "align": align,
    "background_color": List<dynamic>.from(backgroundColor.map((x) => x)),
  };
}