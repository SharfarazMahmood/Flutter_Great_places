import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    @required this.latitude,
    @required this.longitude, 
    this.address = 'not set yet',
  });
}

class Place {
  final String id;
  final String title;
  PlaceLocation location ;
  final File image;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
