import 'package:flutter/material.dart';
import 'package:radio_taxi_alfa_app/src/utils/shared_pref.dart';
import 'package:radio_taxi_alfa_app/src/providers/auth_provider.dart';

class HomeControlador {
  BuildContext context;
  SharedPref _sharedPref;
  AuthProvider _authProvider;

  String _tipoUsuario;
  String _notificacion;

  Future init(BuildContext context) async {
    print('Se Inicio Home Controlador');
    this.context = context;
    _sharedPref = new SharedPref();
    _authProvider = new AuthProvider();

    _tipoUsuario = await _sharedPref.leer('tipoUsuario');
    _notificacion = await _sharedPref.leer('esNotificacion');
    verificarUsuarioAutenticado();
  }

  void verificarUsuarioAutenticado() {
    bool logeado = _authProvider.estaLogeado();
    if (logeado) {

      if(_notificacion != 'true') {
        if (_tipoUsuario == 'Cliente') {
          Navigator.pushNamedAndRemoveUntil(context, 'cliente/mapa', (route) => false);
        } else if (_tipoUsuario == 'Taxista') {
          Navigator.pushNamedAndRemoveUntil(context, 'taxista/mapa', (route) => false);
        } else if (_tipoUsuario == 'Administrador') {
          Navigator.pushNamedAndRemoveUntil(context, 'administrador/mapa', (route) => false);
        }
      }
    } else {
      print('NO ESTA LOGUEADO EL USUARIO');
    }
  }

  void abrirIniciarSesion(String tipoUsuario) {
    guardarTipoUsuario(tipoUsuario);
    Navigator.pushNamed(context, 'iniciar_sesion');
  }

  void guardarTipoUsuario(String tipoUsuario) async {
    await _sharedPref.guardar('tipoUsuario', tipoUsuario);
  }
}
