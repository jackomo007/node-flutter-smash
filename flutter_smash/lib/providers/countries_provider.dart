import 'package:flutter/cupertino.dart';
import 'package:flutter_smash/models/country.dart';
import 'package:flutter_smash/services/firestore_service.dart';

class CountriesProvider with ChangeNotifier {
  List<Country> _countries = [];
  FirestoreService _firestoreService = FirestoreService();

  List<Country> get countries => _countries;

  Future<void> fetchCountries() async {
    _countries = await _firestoreService.getCountries();
    notifyListeners();
  }
}
