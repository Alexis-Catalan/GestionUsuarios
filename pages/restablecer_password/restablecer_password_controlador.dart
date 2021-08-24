import 'package:flutter/material.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:radio_taxi_alfa_app/src/providers/auth_provider.dart';
import 'package:radio_taxi_alfa_app/src/utils/snackbar.dart' as utils;


class RestablecerPasswordControlador {
  BuildContext context;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  TextEditingController correoControlador = new TextEditingController();

  AuthProvider _authProvider;

  Future init(BuildContext context) async {
    print('Se Inicio Restablecer Password Controlador');
    this.context = context;
    _authProvider = new AuthProvider();
  }

  void RestablecerPassword() async {
    String correo = correoControlador.text.trim();

    if (correo.isEmpty) {
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'Debes rellenar el campo.');
      return;
    }

    bool correoValido = RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$").hasMatch(correo);

    if (!correoValido) {
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'El correo electrónico no es válido.');
      return;
    }

    try {
      bool correoEnviado = await _authProvider.restablecerPassword(correo);

      if (correoEnviado) {
        utils.Snackbar.showSnackbar(context, key, utils.Colors.Azul, 'Se ha enviado un correo electrónico de restablecimiento de contraseña.');
        Future.delayed(Duration(milliseconds: 2000), () {
          Navigator.of(context).pop();
        });
      } else {
        utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'No hay ningún registro de usuario que corresponda a este correo electrónico.');
      }
    } catch (error) {
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'Error $error');
    }
  }
}
