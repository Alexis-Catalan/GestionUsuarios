import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:radio_taxi_alfa_app/src/widgets/button_app.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:radio_taxi_alfa_app/src/pages/iniciar_sesion/iniciar_sesion_controlador.dart';

class IniciarSesionPage extends StatefulWidget {
  @override
  _IniciarSesionPageState createState() => _IniciarSesionPageState();
}

class _IniciarSesionPageState extends State<IniciarSesionPage> {
  IniciarSesionControlador _con = new IniciarSesionControlador();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        centerTitle: true,
        title: Text('Iniciar sesión'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appEncabezado(),
            _txtDescripcion(),
            _txtSesion(),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
            ),
            _edtCampoCorreo(),
            _edtCampoPassword(),
            _btnRestablecerPassword(),
            _btnIniciarSesion(),
            _btnRegistrarse()
          ],
        ),
      ),
    );
  }

  Widget _appEncabezado() {
    return ClipPath(
      clipper: DiagonalPathClipperTwo(),
      child: Container(
          color: utils.Colors.temaColor,
          height: MediaQuery.of(context).size.height * 0.22,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/img/logo_app.png',
                    width: 150,
                    height: 115,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('UN SERVICIO',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text('RÁPIDO, SEGURO',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text('CONFIABLE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      )
    );
  }

  Widget _txtDescripcion() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Usuario como:',
        style: TextStyle(
            color: utils.Colors.degradadoColor, fontSize: 24, fontFamily: 'NimbusSans'),
      ),
    );
  }

  Widget _txtSesion() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        _con.txtUsuario ?? '',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
      ),
    );
  }

  Widget _edtCampoCorreo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: _con.correoControlador,
        cursorColor: utils.Colors.temaColor,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'correo@dominio.com',
            labelText: 'Correo electrónico:',
            suffixIcon: Icon(
              Icons.email,
              color: utils.Colors.temaColor,
            )),
      ),
    );
  }

  Widget _edtCampoPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextField(
        controller: _con.passwordControlador,
        cursorColor: utils.Colors.temaColor,
        obscureText: _con.isPassword,
        decoration: InputDecoration(
            labelText: 'Contraseña:',
            suffixIcon: IconButton(
              icon: _con.isPassword? Icon(Icons.visibility_off) : Icon(Icons.visibility),
              color: utils.Colors.temaColor,
              onPressed: _con.Ocultar,
            )),
      ),
    );
  }

  Widget _btnRestablecerPassword() {
    return GestureDetector(
      onTap: _con.abrirRestablecerPassword,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: TextStyle(
              fontSize: 15,
              color: utils.Colors.temaColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _btnRegistrarse() {
    return GestureDetector(
      onTap: _con.abrirRegistrarse,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          '¿Aún no tienes cuenta? Regístrate',
          style: TextStyle(
              fontSize: 15,
              color: utils.Colors.temaColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _btnIniciarSesion() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ButtonApp(
          onPressed: _con.IniciarSesion,
          text: 'Iniciar sesión',
          icon: Icons.login,
        ));
  }

  void refresh() {
    setState(() {});
  }
}
