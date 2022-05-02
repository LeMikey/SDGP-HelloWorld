import 'package:flutter/material.dart';

import 'firebase_api.dart';
import 'firebase_file.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Community'),
          centerTitle: true,
        ),
        body: const ListImages());
  }
}

class ListImages extends StatefulWidget {
  const ListImages({Key? key}) : super(key: key);

  @override
  State<ListImages> createState() => _ListImagesState();
}

class _ListImagesState extends State<ListImages> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('images/');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data!;

              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(17.0),
                    child: Text(
                        'Here You can view images uploaded by other users in the area',style: TextStyle(fontSize: 23), ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Image.network(file.url),
          )
        ],
      );
}
