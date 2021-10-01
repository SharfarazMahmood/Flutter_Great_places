import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  // const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  bool _imageUrlFound = false;
  String _locMessage = null;

  Future<void> _getCurrentLocation() async {
    final locData = await Location().getLocation();
    // print(locData.latitude);
    // print(locData.longitude);

    setState(() {
      // _previewImageUrl = LocationHelper.generateLocationPreviewImage(latitude: locData.latitude, longitude:locData.longitude );
      //
      _locMessage = 'latitude: ' +
          locData.latitude.toString() +
          ' \nlongitude: ' +
          locData.longitude.toString();
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Current Location:'),
        content: Text(_locMessage),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
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
