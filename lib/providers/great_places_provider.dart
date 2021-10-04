import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../helpers/location_helper.dart';
import '../helpers/sqflite_db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
    PlaceLocation pickedlocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedlocation.latitude,
      pickedlocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: pickedlocation.latitude,
      longitude: pickedlocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: updatedLocation,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'],
              ),
            ))
        .toList();

    notifyListeners();
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void removeItem({String id}) async {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();

    DBHelper.delete('user_places', id);
  }

  void deleteAll() async {
    _items = [];
    notifyListeners();

    DBHelper.deleteAllPlaces('user_places');
  }
}
