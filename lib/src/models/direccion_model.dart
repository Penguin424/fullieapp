// To parse this JSON data, do
//
//     final direccion = direccionFromMap(jsonString);
import 'dart:convert';

Direccion direccionFromMap(String str) => Direccion.fromMap(json.decode(str));

String direccionToMap(Direccion data) => json.encode(data.toMap());

class Direccion {
  Direccion({
    required this.id,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.direccion,
    required this.colonia,
    required this.ciudad,
    required this.estado,
    required this.cruces,
    required this.referencia,
    required this.latitud,
    required this.longitud,
    required this.codigoPostal,
  });

  int id;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String direccion;
  String colonia;
  String ciudad;
  String estado;
  String cruces;
  String referencia;
  double latitud;
  double longitud;
  String codigoPostal;

  factory Direccion.fromMap(Map<String, dynamic> json) => Direccion(
        id: json["id"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        direccion: json["direccion"],
        colonia: json["colonia"],
        ciudad: json["ciudad"],
        estado: json["estado"],
        cruces: json["cruces"],
        referencia: json["referencia"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        codigoPostal: json["codigoPostal"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "direccion": direccion,
        "colonia": colonia,
        "ciudad": ciudad,
        "estado": estado,
        "cruces": cruces,
        "referencia": referencia,
        "latitud": latitud,
        "longitud": longitud,
        "codigoPostal": codigoPostal,
      };
}
