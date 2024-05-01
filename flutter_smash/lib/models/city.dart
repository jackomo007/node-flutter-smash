import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String name;

  City({required this.name});

  factory City.fromFirestore(DocumentSnapshot doc) {
    return City(
      name: doc['name'],
    );
  }
}
