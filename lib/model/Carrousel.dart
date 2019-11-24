// To parse this JSON data, do
//
//     final carrousel = carrouselFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Carrousel {
  final int order;
  final String image;

  Carrousel({
    @required this.order,
    @required this.image,
  });

  factory Carrousel.fromJson(String str) => Carrousel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Carrousel.fromMap(Map<String, dynamic> json) => Carrousel(
    order: json["order"],
    image: json["image"],
  );

  Map<String, dynamic> toMap() => {
    "order": order,
    "image": image,
  };

  @override
  String toString() {
    return 'Carrousel{order: $order, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Carrousel &&
              runtimeType == other.runtimeType &&
              order == other.order &&
              image == other.image;

  @override
  int get hashCode =>
      order.hashCode ^
      image.hashCode;





}