import 'package:flutter/material.dart';
import 'package:great_places/screens/add_places_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

import './providers/great_places_provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home:  const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
