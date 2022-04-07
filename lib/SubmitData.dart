import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SubmitData extends StatefulWidget {
  const SubmitData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubmitDataState();
}

class _SubmitDataState extends State<SubmitData> {
  File? image;

  Future pickImage() async {
    await Permission.camera.request();
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      final imagePath = File(image.path);
      setState(() => this.image = imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Submit Data'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text('Upload Images'),
            TextButton(
              onPressed: () => pickImage(),
              child: Text('Launch Camera'),
            ),
            image!= null ? Image.file(image!, width: 160, height: 160,) : FlutterLogo()
          ],
        ),

    );
  }
}
