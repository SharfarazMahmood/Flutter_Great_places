import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_places_screen.dart';
import '../providers/great_places_provider.dart';
import '../widgets/place_list_item.dart';

class PlacesListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlaceScreen.routeName,
              );
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
                          itemBuilder: (ctx, i) => PlaceListItem(
                            item: greatPlaces.items[i],
                            context: ctx,
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
