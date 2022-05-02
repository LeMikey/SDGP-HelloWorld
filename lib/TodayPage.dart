import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdgp/parseData.dart';
import 'package:sdgp/Loading.dart';

import 'SupportedRegions.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  //create an instance of the GetData class and parseData
  bool loading = true;
  final _dataService = GetData();
  WeatherResponse? _response;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Today'),
              centerTitle: true,
            ),
            body: Container(
                color: Colors.grey[400],
                child: Center(
                  child: Column(
                    children: [
                      Image.network(_response!.iconUrl),
                      Text(
                        _response!.tempInfo.temperature.toString() + '°',
                        style: TextStyle(fontSize: 40),
                      ),
                      Text(
                        _response!.weatherInfo.description,
                        style: TextStyle(fontSize: 25),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              //elevation: 1,
                              side: BorderSide(color: Colors.grey, width: 2)
                            ),
                              onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SupportedRegions()));
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.location_pin),
                                  Text(
                                    'RATHNAPURA',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              )),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Risk Prediction',
                        style: TextStyle(fontSize: 30),),
                    ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('Based on the past data we have gathered around this location there is a',
                          style: TextStyle(fontSize: 20),),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('High Risk of Flooding', style: TextStyle(fontSize: 20),),
                      ),
                    ],
                  ),
                )),
          );
  }

  void _search() async {
    setState(() => loading = true);
    final response = await _dataService.getWeather('Colombo');
    if (this.mounted) {
      setState(() => _response = response);
      setState(() => loading = false);
    }
    print(_response.toString());
  }

  void getFloodPred() async {
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather');

    final response = await http.get(uri);
  }

  @override
  void initState() {
    super.initState();
    setState(() => loading = true);
    _search();
  }
}

class GetData {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': '45e40ad89ec404cc27fbe41436448e30',
      'units': 'metric'
    };
    // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
    final uri = Uri.https(
        'api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
