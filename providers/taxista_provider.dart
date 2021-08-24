import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radio_taxi_alfa_app/src/models/taxista.dart';

class TaxistaProvider {
  CollectionReference _ref;

  TaxistaProvider() {
    _ref = FirebaseFirestore.instance.collection('Taxistas');
  }

  Future<void> crearTaxista(Taxista taxista) {
    String errorMessage;

    try {
      return _ref.doc(taxista.id).set(taxista.toJson());
    } catch (error) {
      print('Error de Registro Taxista: ${error.code} \n ${error.message}');
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }
  }

  Future<Taxista> obtenerId(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Taxista taxista = Taxista.fromJson(document.data());
      return taxista;
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
