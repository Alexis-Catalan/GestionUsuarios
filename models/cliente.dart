import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
  String id;
  String nombreUsuario;
  String correo;
  String telefono;
  String token;
  String imagen;

  Cliente({this.id, this.nombreUsuario, this.correo, this.telefono, this.token, this.imagen});

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
      id: json["id"],
      nombreUsuario: json["nombreUsuario"],
      correo: json["correo"],
      telefono: json["telefono"],
      token: json["token"],
      imagen: json["imagen"]
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombreUsuario": nombreUsuario,
        "correo": correo,
        "telefono": telefono,
        "token": token,
        "imagen": imagen
  };
}
