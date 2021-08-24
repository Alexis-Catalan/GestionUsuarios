import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:radio_taxi_alfa_app/src/pages/home/home_controlador.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeControlador _con = new HomeControlador();

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
      backgroundColor: utils.Colors.temaColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                utils.Colors.temaColor,
                utils.Colors.degradadoColor
              ])),
          child: Column(
            children: [
              _appEncabezado(),
              SizedBox(height: 20),
              _txtSeleccionRol(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _btnImgTipoUsuario(
                      context, 'assets/img/cliente.png', 'Cliente'),
                  _btnImgTipoUsuario(
                      context, 'assets/img/taxista.png', 'Taxista')
                ],
              ),
              SizedBox(height: 20),
              _btnImgTipoUsuario(
                  context, 'assets/img/administrador.png', 'Administrador'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appEncabezado() {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.33,
          child: Column(
            children: [
              SizedBox(height: 10),
              Text('RADIO TAXI ALFA',
                  style: TextStyle(
                      fontFamily: 'OneDay',
                      color: utils.Colors.degradadoColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('"Desarrollador"',
                  style: TextStyle(
                      color: utils.Colors.Rojo,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/img/logo_app.png',
                    width: 140,
                    height: 130,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text('UN SERVICIO',
                            style: TextStyle(
                                color: utils.Colors.degradadoColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Text('RÁPIDO, SEGURO',
                            style: TextStyle(
                                color: utils.Colors.degradadoColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        Text('CONFIABLE',
                            style: TextStyle(
                                color: utils.Colors.degradadoColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget _txtSeleccionRol() {
    return Text(
      'SELECCIONA TU ROL:',
      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'OneDay'),
    );
  }

  Widget _btnImgTipoUsuario(
      BuildContext context, String imagen, String tipoUsuario) {
    return GestureDetector(
      onTap: () => _con.abrirIniciarSesion(tipoUsuario),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagen),
            radius: 50,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: 5),
          Text(
            tipoUsuario,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}
