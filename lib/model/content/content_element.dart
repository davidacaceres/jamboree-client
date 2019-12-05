
import 'package:Pasaporte_2020/model/content/image_conf.dart';
import 'package:Pasaporte_2020/model/content/list_conf.dart';
import 'package:Pasaporte_2020/model/content/paragraph_conf.dart';
import 'package:Pasaporte_2020/model/content/time_line_conf.dart';

class ContentElement {
  ParagraphConf paragraphConf;
  ImageConf imageConf;
  ListConf  listConf;
  TimeLineConf timeLineConf;

  ContentElement({
    this.paragraphConf,
    this.imageConf,
    this.listConf,
    this.timeLineConf
  });

  factory ContentElement.fromMap(Map<String, dynamic> json) => ContentElement(
    paragraphConf: json["paragraph_conf"] == null
        ? null
        : ParagraphConf.fromMap(json["paragraph_conf"]),
    imageConf: json["image_conf"] == null
        ? null
        : ImageConf.fromMap(json["image_conf"]),
    listConf: json["list_conf"] == null
        ? null
        : ListConf.fromMap(json["list_conf"]),
    timeLineConf: json["time_line_conf"] == null
        ? null
        : TimeLineConf.fromMap(json["time_line_conf"]),
  );

  Map<String, dynamic> toMap() => {
    "paragraph_conf": paragraphConf == null ? null : paragraphConf.toMap(),
    "image_conf": imageConf == null ? null : imageConf.toMap(),
    "list_conf": listConf == null ? null : listConf.toMap(),
    "time_line_conf": timeLineConf == null ? null : timeLineConf.toMap(),
  };
}