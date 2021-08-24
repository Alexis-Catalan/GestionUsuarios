import 'dart:convert';

Taxista taxistaFromJson(String str) => Taxista.fromJson(json.decode(str));

String taxistaToJson(Taxista data) => json.encode(data.toJson());

class Taxista {
  String id;
  String nombreUsuario;
  String correo;
  String telefono;
  String placas;
  String token;
  String imagen;

  Taxista(
      {this.id,
      this.nombreUsuario,
      this.correo,
      this.telefono,
      this.placas,
      this.token,
      this.imagen
      });

  factory Taxista.fromJson(Map<String, dynamic> json) => Taxista(
      id: json["id"],
      nombreUsuario: json["nombreUsuario"],
      correo: json["correo"],
      telefono: json["telefono"],
      placas: json["placas"],
      token: json["token"],
      imagen: json["imagen"]
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "correo": correo,
        "telefono": telefono,
        "placas": placas,
        "token": token,
        "imagen": imagen
  };
}
