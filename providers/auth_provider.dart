import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth;
  static String errorAuth;

  AuthProvider() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  bool estaLogeado() {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      return false;
    }
    return true;
  }

  User obtenerUsuario() {
    return _firebaseAuth.currentUser;
  }

  Future<bool> registrarUsuario(String correo, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: correo, password: password);
    } catch (error) {
      print('Error de Registro Usuario: ${error.code} \n ${error.message}');
      errorMessage = error.code;
      return false;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> iniciarSesion(String correo, String password) async {
    String errorMessage;

    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: correo, password: password);
    } catch (error) {
      print('Error de IniciarSesion Usuario: ${error.code} \n ${error.message}');
      errorMessage = error.code;
      errorAuth = error.code;
      return false;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<bool> restablecerPassword(String correo) async {
    String errorMessage;

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: correo);
    } catch (error) {
      print('Error de Restablecer Contraseña: ${error.code} \n ${error.message}');
      errorMessage = error.code;
      return false;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
    return true;
  }

  Future<void> cerrarSesion() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
