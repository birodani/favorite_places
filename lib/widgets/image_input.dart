import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  _takePicture() async {
    final _imagePicker = ImagePicker();
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    setState(() {
      _selectedImage = File(image.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: TextButton.icon(
        onPressed: () {
          _takePicture();
        },
        label: const Text('Take a picture!'),
        icon: const Icon(Icons.camera),
      ),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: () => _takePicture(),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
        ),
      );
    }

    return content;
  }
}
