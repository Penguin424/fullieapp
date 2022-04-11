// To parse this JSON data, do
//
//     final userSocialNet = userSocialNetFromMap(jsonString);

import 'dart:convert';

UserSocialNet userSocialNetFromMap(String str) =>
    UserSocialNet.fromMap(json.decode(str));

String userSocialNetToMap(UserSocialNet data) => json.encode(data.toMap());

class UserSocialNet {
  UserSocialNet({
    required this.jwt,
    required this.user,
  });

  String jwt;
  User user;

  factory UserSocialNet.fromMap(Map<String, dynamic> json) => UserSocialNet(
        jwt: json["jwt"],
        user: User.fromMap(json["user"]),
      );

  Map<String, dynamic> toMap() => {
        "jwt": jwt,
        "user": user.toMap(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.usuariodireccion,
    required this.telefono,
    required this.imagen,
    required this.instituciones,
    required this.especialidades,
    required this.consultas,
    required this.consultaspres,
    required this.detalleservicios,
    required this.citas,
    required this.citasPaciente,
  });

  int id;
  String username;
  String email;
  String provider;
  bool confirmed;
  dynamic blocked;
  Role role;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic usuariodireccion;
  dynamic telefono;
  dynamic imagen;
  List<dynamic> instituciones;
  List<dynamic> especialidades;
  List<dynamic> consultas;
  List<dynamic> consultaspres;
  List<dynamic> detalleservicios;
  List<dynamic> citas;
  List<dynamic> citasPaciente;

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        role: Role.fromMap(json["role"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        usuariodireccion: json["usuariodireccion"],
        telefono: json["telefono"],
        imagen: json["imagen"],
        instituciones: List<dynamic>.from(json["instituciones"].map((x) => x)),
        especialidades:
            List<dynamic>.from(json["especialidades"].map((x) => x)),
        consultas: List<dynamic>.from(json["consultas"].map((x) => x)),
        consultaspres: List<dynamic>.from(json["consultaspres"].map((x) => x)),
        detalleservicios:
            List<dynamic>.from(json["detalleservicios"].map((x) => x)),
        citas: List<dynamic>.from(json["citas"].map((x) => x)),
        citasPaciente: List<dynamic>.from(json["citasPaciente"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "blocked": blocked,
        "role": role.toMap(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "usuariodireccion": usuariodireccion,
        "telefono": telefono,
        "imagen": imagen,
        "instituciones": List<dynamic>.from(instituciones.map((x) => x)),
        "especialidades": List<dynamic>.from(especialidades.map((x) => x)),
        "consultas": List<dynamic>.from(consultas.map((x) => x)),
        "consultaspres": List<dynamic>.from(consultaspres.map((x) => x)),
        "detalleservicios": List<dynamic>.from(detalleservicios.map((x) => x)),
        "citas": List<dynamic>.from(citas.map((x) => x)),
        "citasPaciente": List<dynamic>.from(citasPaciente.map((x) => x)),
      };
}

class Role {
  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
  });

  int id;
  String name;
  String description;
  String type;

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "type": type,
      };
}
