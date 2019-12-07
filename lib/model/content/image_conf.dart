
class ImageConf {
  String source;
  String align;
  List<int> backgroundColor;
  bool ownViewer;

  ImageConf({
    this.source,
    this.align,
    this.backgroundColor,
    this.ownViewer
  });

  factory ImageConf.fromMap(Map<String, dynamic> json) => ImageConf(
    source: json["source"],
    align: json["align"],
    ownViewer: json["ownViewer"] == null ? false : json["ownViewer"],

    backgroundColor: json["background_color"] == null
        ? null
        : List<int>.from(json["background_color"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "source": source,
    "align": align,
    "background_color": List<dynamic>.from(backgroundColor.map((x) => x)),
    "ownViewer": ownViewer,

  };
}