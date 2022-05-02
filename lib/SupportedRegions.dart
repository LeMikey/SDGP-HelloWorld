import 'package:flutter/material.dart';

class SupportedRegions extends StatelessWidget {
  const SupportedRegions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supported Regions'),
        centerTitle: true,
      ),
      body: ListView(
        children:  <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'We currently provide risk predictions regarding floods and landslides for the following region(s).',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_pin),
              title: const Text('Rathnapura'),
              onTap: (){Navigator.pop(context);},
            ),
          ),
        ],
      ),
    );
  }
}
