import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smash/models/city.dart';
import 'package:flutter_smash/models/country.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Country>> getCountries() async {
    var snapshot = await _db.collection('countries').get();
    return snapshot.docs.map((doc) => Country.fromFirestore(doc)).toList();
  }

  Stream<List<City>> getCities(String countryId) {
    return _db.collection('countries').doc(countryId).collection('cities').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => City.fromFirestore(doc)).toList(),
    );
  }
}
