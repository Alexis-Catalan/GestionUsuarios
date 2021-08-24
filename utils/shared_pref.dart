import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void guardar(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> leer(String key) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key));
  }

  Future<bool> contiene(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> eliminar(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
