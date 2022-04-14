import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sdgp/SubmitData.dart';
import 'package:sdgp/TodayPage.dart';
import 'package:sdgp/CommunityPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool connected = false;


  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {final _connected = status == InternetConnectionStatus.connected;
    setState(() => connected = _connected);
    });
  }

  @override
  // This widget is the root of your application.
  Widget build(BuildContext context) {
    //check for internet connection
    if (connected == true) {
      print('we connected boi');
      return MaterialApp(
        title: 'Hello Disaster',
        home: Navbar(),
      );
    } else {
      print('we not connected boi');
      return MaterialApp(
          title: 'Hello Disaster',
          home: AlertDialog(
            title: const Text('Check your Network Connection'),
            content: const Text(
                'You must have an active internet connection to proceed'),
            actions: [
              TextButton(
                  onPressed: () async {
                    connected = await InternetConnectionChecker().hasConnection;
                  },
                  child: const Text('Retry'))
            ],
          ));
    }
  }

  void isConnected() async {
    connected = await InternetConnectionChecker().hasConnection;
  }
}

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  static int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    TodayPage(),
    CoummunityPage(),
    SubmitData(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _NavbarState._widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sunny),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_people),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Submit Data',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ));
  }
}
