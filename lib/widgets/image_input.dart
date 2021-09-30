import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart' as SysPath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late File _storedImage;
  bool _imageStored = false;

  Future<void> _capture() async {
    final imagePicker = ImagePicker();
    final XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      ////////////////////////////////////////////////////////
      ///// The property 'path' can't be unconditionally accessed because
      ///// the receiver can be 'null'.
      ///// Try making the access conditional (using '?.') or adding a null ///// check to the target ('!')
      ///////////////////////////////////////////////////////
      _storedImage = File(imageFile.path);
      _imageStored = true;
    });
    final appDir = await SysPath.getApplicationDocumentsDirectory();
    final fileName = Path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 220,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageStored
              ? Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(
              Icons.camera,
              color: Colors.pink,
              size: 24.0,
            ),
            style: TextButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shadowColor: Theme.of(context).accentColor,
            ),
            label: const Text('Capture'),
            onPressed: _capture,
          ),
        ),
      ],
    );
  }
}
