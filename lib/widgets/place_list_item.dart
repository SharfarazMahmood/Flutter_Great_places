import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';
import '../providers/great_places_provider.dart';
import '../screens/place_details_screen.dart';

class PlaceListItem extends StatelessWidget {
  final Place item;
  final BuildContext context;

  const PlaceListItem({
    Key key,
    this.item,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure ?'),
            // content: const Text('Remove the place ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<GreatPlaces>(context, listen: false)
            .removeItem(id: item.id);
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: FileImage(
            item.image,
          ),
        ),
        title: Text(item.title),
        subtitle: Text("Lat: " +
            item.location.latitude.toString() +
            " Lng:" +
            item.location.longitude.toString()),
        onTap: () {
          Navigator.of(context).pushNamed(
            PlaceDetails.routeName,
            arguments: item.id,
          );
        },
      ),
    );
  }
}
