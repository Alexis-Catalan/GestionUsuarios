import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:radio_taxi_alfa_app/src/models/administrador.dart';
import 'package:radio_taxi_alfa_app/src/models/cliente.dart';
import 'package:radio_taxi_alfa_app/src/models/taxista.dart';
import 'package:radio_taxi_alfa_app/src/providers/administrador_provider.dart';
import 'package:radio_taxi_alfa_app/src/utils/shared_pref.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:radio_taxi_alfa_app/src/providers/auth_provider.dart';
import 'package:radio_taxi_alfa_app/src/utils/snackbar.dart' as utils;
import 'package:radio_taxi_alfa_app/src/utils/my_progress_dialog.dart';
import 'package:radio_taxi_alfa_app/src/providers/cliente_provider.dart';
import 'package:radio_taxi_alfa_app/src/providers/taxista_provider.dart';
import 'package:radio_taxi_alfa_app/src/providers/auth_provider.dart' as m;

class IniciarSesionControlador {
  BuildContext context;
  Function refresh;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  SharedPref _sharedPref;
  String _tipoUsuario;
  String txtUsuario;

  AuthProvider _authProvider;
  ClienteProvider _clienteProvider;
  TaxistaProvider _taxistaProvider;
  AdministradorProvider _administradorProvider;
  ProgressDialog _progressDialog;

  TextEditingController correoControlador = new TextEditingController();
  TextEditingController passwordControlador = new TextEditingController();

  bool isPassword = true;

  Future init(BuildContext context, Function refresh) async {
    print('Se inicio Inicar Sesion Controlador');
    this.context = context;
    this.refresh = refresh;
    _sharedPref = new SharedPref();
    _tipoUsuario = await _sharedPref.leer('tipoUsuario');
    txtUsuario = _tipoUsuario;
    _authProvider = new AuthProvider();
    _clienteProvider = new ClienteProvider();
    _taxistaProvider = new TaxistaProvider();
    _administradorProvider = new AdministradorProvider();
    _progressDialog = MyProgressDialog.createProgressDialog(context, 'Espere un momento...');
    print('==================== TIPO DE USUARIO==================');
    print(_tipoUsuario);
    refresh();
  }

  void Ocultar(){
    isPassword = !isPassword;
    refresh();
  }
  void abrirRestablecerPassword() {
    Navigator.pushNamed(context, 'restablecer_password');
  }

  void IniciarSesion() async {
    String correo = correoControlador.text.trim();
    String password = passwordControlador.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'Debes rellenar todos los campos.');
      return;
    }

    bool correoValido = RegExp(r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$").hasMatch(correo);

    if (!correoValido) {
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'El correo electrónico no es válido.');
      return;
    }

    try {
      _progressDialog.show();
      bool logeado = await _authProvider.iniciarSesion(correo, password);

      if (logeado) {
        if (_tipoUsuario == 'Cliente') {
          Cliente cliente = await _clienteProvider.obtenerId(_authProvider.obtenerUsuario().uid);
          print('CLIENTE: $cliente');

          if (cliente != null) {
            _progressDialog.hide();
            Navigator.pushNamedAndRemoveUntil(context, 'cliente/mapa', (route) => false);
          } else {
            _progressDialog.hide();
            utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'El usuario a ingresar no pertenece a Cliente.');
            await _authProvider.cerrarSesion();
          }
        } else if (_tipoUsuario == 'Taxista') {
          Taxista taxista = await _taxistaProvider.obtenerId(_authProvider.obtenerUsuario().uid);
          print('Taxista: $taxista');

          if (taxista != null) {
            _progressDialog.hide();
            Navigator.pushNamedAndRemoveUntil(context, 'taxista/mapa', (route) => false);
          } else {
            _progressDialog.hide();
            utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'El usuario a ingresar no pertenece a Taxista.');
            await _authProvider.cerrarSesion();
          }
        } else if (_tipoUsuario == 'Administrador') {
          Administrador administrador = await _administradorProvider.obtenerId(_authProvider.obtenerUsuario().uid);
          print('Administrador: $administrador');

          if (administrador != null) {
            _progressDialog.hide();
            Navigator.pushNamedAndRemoveUntil(context, 'administrador/mapa', (route) => false);
          } else {
            _progressDialog.hide();
            utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'El usuario a ingresar no pertenece a Administrador.');
            await _authProvider.cerrarSesion();
          }
        }
      } else {
        _progressDialog.hide();
        String mensajaError;
        if(m.AuthProvider.errorAuth == 'user-not-found'){
          mensajaError = 'No hay ningún registro de usuario que corresponda a este correo electrónico.';
        } else if(m.AuthProvider.errorAuth == 'wrong-password'){
          mensajaError = 'La contraseña que ingresaste es incorrecta.';
        }else {
          mensajaError = 'El usuario no se pudo autenticar. Posible error de conexión a internet.';
        }
        utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, mensajaError);
      }
    } catch (error) {
      _progressDialog.hide();
      utils.Snackbar.showSnackbar(context, key, utils.Colors.Rojo, 'Error: $error');
    }
  }

  void abrirRegistrarse() {
    if (_tipoUsuario == 'Cliente') {
      Navigator.pushNamed(context, 'cliente/registrarse');
    } else if(_tipoUsuario == 'Taxista'){
      Navigator.pushNamed(context, 'taxista/registrarse');
    }else if(_tipoUsuario == 'Administrador'){
      Navigator.pushNamed(context, 'administrador/registrarse');
    }
  }

}
