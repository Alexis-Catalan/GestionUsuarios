import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radio_taxi_alfa_app/src/models/cliente.dart';

class ClienteProvider {
  CollectionReference _ref;

  ClienteProvider() {
    _ref = FirebaseFirestore.instance.collection('Clientes');
  }

  Future<void> crearCliente(Cliente cliente) {
    String errorMessage;

    try {
      return _ref.doc(cliente.id).set(cliente.toJson());
    } catch (error) {
      print('Error de Registro Cliente: ${error.code} \n ${error.message}');
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Cliente> obtenerId(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Cliente cliente = Cliente.fromJson(document.data());
      return cliente;
    }

    return null;
  }

  Stream<DocumentSnapshot> obtenerIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<void> actualizar(Map<String, dynamic> data, String id) {
    return _ref.doc(id).update(data);
  }
}
