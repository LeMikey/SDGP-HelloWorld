import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/ml/v1.dart';

// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';



class SubmitData extends StatefulWidget {
  const SubmitData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SubmitDataState();
}

class _SubmitDataState extends State<SubmitData> {
  FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;

  var storage = FirebaseStorage.instance;
  File? image;
  File? modelFile;


  Future pickImage() async {
    await Permission.camera.request();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      final file = File(image.path);
      final path = 'images/${image.name}';
      final ref = FirebaseStorage.instance.ref().child(path);
      ref.putFile(file);


      // setState(() => this.image = imagePath);
      // TaskSnapshot snapshot = await storage
      //     .ref()
      //     .child("images/bro")
      //     .putFile(imagePath);

    }

  }

  @override
  Widget build(BuildContext context) {
    //getModel();
    return Scaffold(
        appBar: AppBar(
          title: Text('Submit Data'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text('Here you can submit your own data to report flooding and landslidng in your area.', style: TextStyle(fontSize: 22),),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text('Upload Images of Flooding and Landslides in your area', style: TextStyle(fontSize: 19),),
            ),
            TextButton(
              onPressed: () => pickImage(),
              child: Text('Launch Camera', style: TextStyle(fontSize: 19),),
            ),
            image!= null ? Image.file(image!, width: 160, height: 160,) : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(Icons.add_a_photo),
            )
          ],
        ),

    );
  }
}
