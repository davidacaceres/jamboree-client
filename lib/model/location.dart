import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<UbicacionModel> ubicacionFromJson(String str) => List<UbicacionModel>.from(json.decode(str).map((x) => UbicacionModel.fromJson(x)));

String ubicacionToJson(List<UbicacionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UbicacionModel {
  String id;
  String nombre;
  double latitud;
  double longitud;
  String imagen;

  UbicacionModel({
    this.id,
    this.nombre,
    this.latitud,
    this.longitud,
    this.imagen,
  });

  factory UbicacionModel.fromJson(Map<String, dynamic> json) => UbicacionModel(
    id: json["id"],
    nombre: json["nombre"],
    latitud: json["latitud"] != null ? json["latitud"].toDouble() : 0,
    longitud: json["longitud"] != null ? json["longitud"].toDouble() : 0,
    imagen: json["imagen"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "latitud": latitud,
    "longitud": longitud,
    "imagen": imagen,
  };

  LatLng getLatLong(){
    return LatLng(this.latitud, this.longitud);
  }
}