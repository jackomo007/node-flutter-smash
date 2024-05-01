import 'package:flutter/material.dart';
import 'package:flutter_smash/providers/cities_providers.dart';
import 'package:provider/provider.dart';

class CitiesListScreen extends StatelessWidget {
  final String countryId;

  CitiesListScreen({Key? key, required this.countryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CitiesProvider>(context).fetchCities(countryId);
    var cities = Provider.of<CitiesProvider>(context).cities;

    return Scaffold(
      appBar: AppBar(title: const Text('Cities'), toolbarHeight: 100.0,),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index].name),
          );
        },
      ),
    );
  }
}
