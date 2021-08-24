import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:radio_taxi_alfa_app/src/widgets/button_app.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:radio_taxi_alfa_app/src/pages/restablecer_password/restablecer_password_controlador.dart';

class RestablecerPasswordPage extends StatefulWidget {
  @override
  _RestablecerPasswordPageState createState() =>
      _RestablecerPasswordPageState();
}

class _RestablecerPasswordPageState extends State<RestablecerPasswordPage> {
  RestablecerPasswordControlador _con = new RestablecerPasswordControlador();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
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
        title: Text('Restablecer contraseña'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appEncabezado(),
            _txtDescripcion(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            _edtCampoCorreo(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            _btnRestablecerPassword()
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        'Ingresa el correo electrónico con el que se registro en esta aplicación.',
        style: TextStyle(
            color: utils.Colors.degradadoColor, fontSize: 20, fontFamily: 'NimbusSans'),
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
              Icons.email_rounded,
              color: utils.Colors.temaColor,
            )),
      ),
    );
  }

  Widget _btnRestablecerPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: ButtonApp(
          onPressed: _con.RestablecerPassword,
          text: 'Restablecer contraseña',
        icon: Icons.forward_to_inbox,
      ),
    );
  }
}
