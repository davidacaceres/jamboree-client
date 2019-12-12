// To parse this JSON data, do
//
//     final ubicacion = ubicacionFromJson(jsonSt

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Ubicacion {
  final String categoria;
  final bool expand;
  final String imagen;
  final List<Location> locations;

  Ubicacion({
    @required this.categoria,
    @required this.locations,
    @required this.expand,
    @required this.imagen,
  });

  factory Ubicacion.fromJson(String str) => Ubicacion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ubicacion.fromMap(Map<String, dynamic> json) => Ubicacion(
    categoria: json["categoria"],
    expand: json["expand"] == null ? false : json["expand"],
    locations: List<Location>.from(json["locations"].map((x) => Location.fromMap(x))),
    imagen: json["imagen"] == null ? null : json["imagen"],
  );

  Map<String, dynamic> toMap() => {
    "categoria": categoria,
    "locations": List<dynamic>.from(locations.map((x) => x.toMap())),
    "expand": expand,
    "imagen": imagen,
  };
}

class Location {
  final String id;
  final String nombre;
  final String imagen;
  final double latitud;
  final double longitud;

  Location({
    @required this.id,
    @required this.nombre,
    @required this.imagen,
    @required this.latitud,
    @required this.longitud,
  });

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    id: json["id"],
    nombre: json["nombre"],
    imagen: json["imagen"],
    latitud: json["latitud"].toDouble(),
    longitud: json["longitud"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "imagen": imagen,
    "latitud": latitud,
    "longitud": longitud,
  };

  LatLng getLatLong(){
    return LatLng(this.latitud, this.longitud);
  }
}
