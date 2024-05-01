import 'package:cloud_firestore/cloud_firestore.dart';

class Country {
  final String id;
  final String name;

  Country({required this.id, required this.name});

  factory Country.fromFirestore(DocumentSnapshot doc) {
    return Country(
      id: doc.id,
      name: doc['name'],
    );
  }
}
