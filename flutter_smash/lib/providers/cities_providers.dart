import 'package:flutter/cupertino.dart';
import 'package:flutter_smash/models/city.dart';
import 'package:flutter_smash/services/firestore_service.dart';

class CitiesProvider with ChangeNotifier {
  List<City> _cities = [];
  FirestoreService _firestoreService = FirestoreService();

  List<City> get cities => _cities;

  void fetchCities(String countryId) {
    _firestoreService.getCities(countryId).listen((citiesList) {
      _cities = citiesList;
      notifyListeners();
    });
  }
}
