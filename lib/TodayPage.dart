import 'package:flutter/material.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Today'),
    centerTitle: true,
    ),
      body: Column(
        children: [
          Container(
            height: 300,
            color: Colors.grey,
    ),
          Container( // this container uses all of the remaining space
            color: Colors.black,
    )],
    ),
    );
  }
}
