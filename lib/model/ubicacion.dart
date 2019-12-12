// To parse this JSON data, do
//
//     final ubicacion = ubicacionFromJson(jsonSt

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Ubicacion {
  final String category;
  final bool expand;
  final String image;
  final List<Location> locations;

  Ubicacion({
    @required this.category,
    @required this.locations,
    @required this.expand,
    @required this.image,
  });

  factory Ubicacion.fromJson(String str) => Ubicacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ubicacion.fromMap(Map<String, dynamic> json) => Ubicacion(
    category: json["category"],
    expand: json["expand"] == null ? false : json["expand"],
    locations: List<Location>.from(json["locations"].map((x) => Location.fromMap(x))),
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toMap() => {
    "category": category,
    "locations": List<dynamic>.from(locations.map((x) => x.toMap())),
    "expand": expand,
    "image": image,
  };
}

class Location {
  final String id;
  final String title;
  final String image;
  final double latitude;
  final double longitude;

  Location({
    @required this.id,
    @required this.title,
    @required this.image,
    @required this.latitude,
    @required this.longitude,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
  };

  LatLng getLatLong(){
    return LatLng(this.latitude, this.longitude);
  }
}
