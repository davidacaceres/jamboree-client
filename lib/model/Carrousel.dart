// To parse this JSON data, do
//
//     final carrousel = carrouselFromJson(jsonString);

import 'dart:convert';

List<Carrousel> carrouselFromJson(String str) => List<Carrousel>.from(json.decode(str).map((x) => Carrousel.fromMap(x)));

String carrouselToJson(List<Carrousel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Carrousel {
  int order;
  String type;
  String image;

  Carrousel({
    this.order,
    this.type,
    this.image,
  });

  factory Carrousel.fromMap(Map<String, dynamic> json) => Carrousel(
    order: json["order"],
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "order": order,
    "type": type,
    "image": image,
  };
}
