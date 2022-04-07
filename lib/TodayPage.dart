import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sdgp/parseData.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  //create an instance of the GetData class and parseData
  final _dataService = GetData();
  late WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    _search();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        centerTitle: true,
      ),
      body: Container(
          color: Colors.grey,
          child: Center(
            child: Column(
              children: [
                Image.network(_response.iconUrl),
                Text(
                  _response.tempInfo.temperature.toString() + '°',
                  style: TextStyle(fontSize: 40),
                ),
                Text(
                  _response.weatherInfo.description,
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          )),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather('Colombo');
    setState(() => _response = response);
    print(_response.toString());
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
