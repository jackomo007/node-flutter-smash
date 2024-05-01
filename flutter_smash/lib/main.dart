import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_smash/firebase_options.dart';
import 'package:flutter_smash/providers/cities_providers.dart';
import 'package:flutter_smash/providers/countries_provider.dart';
import 'package:flutter_smash/screens/countries_list_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountriesProvider()),
        ChangeNotifierProvider(create: (_) => CitiesProvider()),
      ],
      child: MaterialApp(
        title: 'Country City Navigator',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CountriesListScreen(),
      ),
    );
  }
}
