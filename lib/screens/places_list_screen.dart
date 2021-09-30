import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../screens/add_places_screen.dart';
import '../providers/great_places_provider.dart';


class PlacesListScreen extends StatelessWidget {
  // const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, grtPlacesSnapshot) =>
            grtPlacesSnapshot.connectionState == ConnectionState.waiting
                ? const Center(
                  child: CircularProgressIndicator(),
                )
                : Consumer<GreatPlaces>(
                    child: const Center(
                      child: Text('Got no places yet, start adding some!'),
                    ),
                    builder: (ctx, greatPlaces, ch) {
                      if (greatPlaces.items.isEmpty) {
                        return const Center(
                          child: Text('Got no places yet, start adding some!'),
                        );
                      }
                      if (greatPlaces.items.isNotEmpty) {
                        return ListView.builder(
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (ctx, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                greatPlaces.items[i].image,
                              ),
                            ),
                            title: Text(greatPlaces.items[i].title),
                            onTap: () {
                              // Go to detail page ...
                            },
                          ),
                        );
                      }
                      return const Center(
                        child: Text('You did not save any places!!!'),
                      );
                    },
                  ),
      ),
    );
  }
}
