// To parse this JSON data, do
//
//     final infoUpdate = infoUpdateFromJson(jsonString);
/*
{
  "fecha":"1990-12-25T12:00:00Z",
  "descripcion": "Incorporacion datos",
  "urls":[
      {
        "tipo":"contenido",
        "url":"http://contenido",
        "version": 2.1
      },{
        "tipo":"carrusel",
        "url":"http://carrusel",
        "version": 2.1
      },
      {
         "tipo":"ubicaciones",
        "url":"http://contenido",
        "version": 0.1
      }
      ]
}
 */

import 'package:meta/meta.dart';
import 'dart:convert';



class InfoUpdate {
  final DateTime fecha;
  final String descripcion;
  final List<Url> urls;

  InfoUpdate({
    @required this.fecha,
    @required this.descripcion,
    @required this.urls,
  });

  factory InfoUpdate.fromJson(String str) => InfoUpdate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoUpdate.fromMap(Map<String, dynamic> json) => InfoUpdate(
    fecha: DateTime.parse(json["fecha"]),
    descripcion: json["descripcion"],
    urls: List<Url>.from(json["urls"].map((x) => Url.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "fecha": fecha.toIso8601String(),
    "descripcion": descripcion,
    "urls": List<dynamic>.from(urls.map((x) => x.toMap())),
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is InfoUpdate &&
              runtimeType == other.runtimeType &&
              fecha == other.fecha &&
              descripcion == other.descripcion &&
              urls == other.urls;

  @override
  int get hashCode =>
      fecha.hashCode ^
      descripcion.hashCode ^
      urls.hashCode;

  @override
  String toString() {
    return 'InfoUpdate{fecha: $fecha, descripcion: $descripcion, urls: $urls}';
  }


}

class Url {
  final String tipo;
  final String url;
  final double version;

  Url({
    @required this.tipo,
    @required this.url,
    @required this.version,
  });

  factory Url.fromJson(String str) => Url.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Url.fromMap(Map<String, dynamic> json) => Url(
    tipo: json["tipo"],
    url: json["url"],
    version: json["version"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "tipo": tipo,
    "url": url,
    "version": version,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Url &&
              runtimeType == other.runtimeType &&
              tipo == other.tipo &&
              url == other.url &&
              version == other.version;

  @override
  int get hashCode =>
      tipo.hashCode ^
      url.hashCode ^
      version.hashCode;

  @override
  String toString() {
    return 'Url{tipo: $tipo, url: $url, version: $version}';
  }


}

