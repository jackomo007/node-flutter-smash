import 'package:flutter/material.dart';
import 'package:flutter_smash/providers/countries_provider.dart';
import 'package:flutter_smash/screens/cities_list_screen.dart';
import 'package:provider/provider.dart';

class CountriesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<CountriesProvider>(context).fetchCountries();
    var countries = Provider.of<CountriesProvider>(context).countries;

    return Scaffold(
      appBar: AppBar(title: const Text('Countries'), toolbarHeight: 100.0,),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(countries[index].name),
            onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => CitiesListScreen(countryId: countries[index].id))),
          );
        },
      ),
    );
  }
}

