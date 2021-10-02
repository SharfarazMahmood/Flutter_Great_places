import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  const LocationInput({this.onSelectPlace});

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  bool _imageUrlFound = false;
  String _locMessage = null;

  void showMessage(message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Current Location:'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showPreview(double lat, double lng) {
    // final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
    //   latitude: lat,
    //   longitude: lng,
    // );

    setState(() {
      // _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();
      _showPreview(locData.latitude, locData.longitude);

      _locMessage = 'latitude: ' +
          locData.latitude.toString() +
          ' \nlongitude: ' +
          locData.longitude.toString();
      showMessage(_locMessage);
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (error) {
      // print(error);
      showMessage("Unknown Error, Please try again later");
    }
  }

  Future<void> _selectOnMap() async {
    // final LatLng selectedLocation = await Navigator.of(context).push(
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    // print(selectedLocation.latitude);

    print(selectedLocation);
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);

    //........
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? _locMessage != null
                  ? Text(
                      _locMessage,
                      textAlign: TextAlign.center,
                    )
                  : const Text(
                      'No location chosen',
                      textAlign: TextAlign.center,
                    )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.location_on,
                color: Colors.redAccent,
                // size: 24.0,
              ),
              style: TextButton.styleFrom(
                  elevation: 0,
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Theme.of(context).accentColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  )),
              label: const Text('Current Location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.map,
                color: Colors.redAccent,
                // size: 24.0,
              ),
              style: TextButton.styleFrom(
                  elevation: 0,
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shadowColor: Theme.of(context).accentColor,
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  )),
              label: const Text('Select on Map'),
              onPressed: _selectOnMap,
            )
          ],
        ),
      ],
    );
  }
}
