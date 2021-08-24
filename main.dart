import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:radio_taxi_alfa_app/src/pages/administrador/editar/administrador_editar_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/administrador/historial/administrador_historial_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/administrador/historial_detalle/administrador_historial_detalle_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/administrador/mapa/administrador_mapa_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/administrador/registrarse/administrador_registrarse_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/calificacion_viaje/cliente_calificacion_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/editar/cliente_editar_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/historial/cliente_historial_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/historial_detalle/cliente_historial_detalle_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/mapa_viaje/cliente_mapa_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/solicitud_viaje/cliente_solicitud_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/home/home_app_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/home/home_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/informacion_viaje/informacion_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/calificacion_viaje/taxista_calificacion_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/editar/taxista_editar_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/historial/taxista_historial_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/historial_detalle/taxista_historial_detalle_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/mapa_viaje/taxista_mapa_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/solicitud_viaje/taxista_solicitud_viaje_page.dart';
import 'package:radio_taxi_alfa_app/src/providers/push_notificaciones_provider.dart';
import 'package:radio_taxi_alfa_app/src/utils/colors.dart' as utils;
import 'package:radio_taxi_alfa_app/src/pages/cliente/mapa/cliente_mapa_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/mapa/taxista_mapa_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/iniciar_sesion/iniciar_sesion_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/taxista/registrarse/taxista_registrarse_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/registrarse/cliente_registrarse_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/cliente/ruta_informacion/ruta_informacion_page.dart';
import 'package:radio_taxi_alfa_app/src/pages/restablecer_password/restablecer_password_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GlobalKey<NavigatorState> navigatorKer = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificacionesProvider pushNotificacionesProvider = new PushNotificacionesProvider();
    pushNotificacionesProvider.initPushNotificaciones();
    pushNotificacionesProvider.message.listen((data) {
      print('----------------NOTIFICACION NUEVA---------------');
      print(data);
      navigatorKer.currentState.pushNamed('taxista/solicitud/viaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi Alfa',
        navigatorKey: navigatorKer,
        initialRoute: 'home',
        theme: ThemeData(
          fontFamily: 'NimbusSans',
          primaryColor: utils.Colors.temaColor,
        ),
        routes: {
          'home': (BuildContext context) => HomePage(),
          'home/app': (BuildContext context) => HomeAppPage(),
          'iniciar_sesion': (BuildContext context) => IniciarSesionPage(),
          'cliente/registrarse': (BuildContext context) => ClienteRegistrarsePage(),
          'taxista/registrarse': (BuildContext context) => TaxistaRegistrarsePage(),
          'restablecer_password': (BuildContext context) => RestablecerPasswordPage(),
          'cliente/mapa': (BuildContext context) => ClienteMapaPage(),
          'taxista/mapa': (BuildContext context) => TaxistaMapaPage(),
          'cliente/editar': (BuildContext context) => ClienteEditarPage(),
          'taxista/editar': (BuildContext context) => TaxistaEditarPage(),
          'cliente/ruta/info': (BuildContext context) => RutaInformacionPage(),
          'cliente/solicitud/viaje': (BuildContext context) => ClienteSolicitudViajePage(),
          'taxista/solicitud/viaje': (BuildContext context) => TaxistaSolicitudViajePage(),
          'cliente/mapa/viaje': (BuildContext context) => ClienteMapaViajePage(),
          'taxista/mapa/viaje': (BuildContext context) => TaxistaMapaViajePage(),
          'cliente/calificacion/viaje': (BuildContext context) => ClienteCalificacionViajePage(),
          'taxista/calificacion/viaje': (BuildContext context) => TaxistaCalificacionViajePage(),
          'cliente/historial': (BuildContext context) => ClienteHistorialPage(),
          'cliente/historial/detalle': (BuildContext context) => ClienteHistorialDetallePage(),
          'taxista/historial': (BuildContext context) => TaxistaHistorialPage(),
          'taxista/historial/detalle': (BuildContext context) => TaxistaHistorialDetallePage(),
          'administrador/registrarse': (BuildContext context) => AdministradorRegistrarsePage(),
          'administrador/mapa': (BuildContext context) => AdministradorMapaPage(),
          'administrador/editar': (BuildContext context) => AdministradorEditarPage(),
          'administrador/historial': (BuildContext context) => AdministradorHistorialPage(),
          'administrador/historial/detalle': (BuildContext context) => AdministradorHistorialDetallePage(),
          'informacion/viaje': (BuildContext context) => InformacionViajePage()
        });
  }
}
