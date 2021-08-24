import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:radio_taxi_alfa_app/src/pages/home/home_controlador.dart';
import 'package:radio_taxi_alfa_app/src/widgets/button_app.dart';

class HomeAppPage extends StatefulWidget {
  @override
  _HomeAppPageState createState() => _HomeAppPageState();
}

class _HomeAppPageState extends State<HomeAppPage> {
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
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('RADIO TAXI ALFA',
                        style: TextStyle(
                            fontFamily: 'OneDay',
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)
                    ),
                    Image.asset(
                      'assets/img/logo_app.png',
                      width: 190,
                      height: 190,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text('UN SERVICIO',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold)),
                          Text('RÁPIDO, SEGURO',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold)),
                          Text('CONFIABLE',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 37,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ),
          )
      ),
      bottomNavigationBar: _btnComenzar(),
    );
  }

  Widget _btnComenzar() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: ButtonApp(
        onPressed: () => _con.abrirIniciarSesion('Cliente'),
        text: 'Comenzar',
        color: Colors.white,
        textColor: utils.Colors.temaColor,
        icon: Icons.arrow_forward,
      ),
    );
  }

}
