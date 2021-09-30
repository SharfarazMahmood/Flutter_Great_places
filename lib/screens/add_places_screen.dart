import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places_provider.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add_place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  late File _pickedImage;
  bool imagePicked = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occurred'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
    imagePicked = true;
  }

  void _savePlace() {
    String errorMessage = "Unknown Error";
    if (_titleController.text.isEmpty) {
      errorMessage = "Please Enter a Title";
      _showErrorDialog(errorMessage);
      return;
    }
    if (!imagePicked) {
      errorMessage = "Capture an Image";
      _showErrorDialog(errorMessage);
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(onSelectImage: _selectImage),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.add_location,
              color: Colors.pink,
              size: 24.0,
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shadowColor: Theme.of(context).accentColor,
            ),
            label: const Text('Add Place'),
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
