import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot != null) {
            Weather _weather = snapshot.data;
            if (_weather == null) {
              return Text("Error getting weather");
            } else {
              return weatherBox(_weather);
            }
          } else {
            return CircularProgressIndicator();
          }
        },
        future: getCurrentWeather(),
      )),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(children: <Widget>[
      Text("${_weather.temp}*C"),
      Text("${_weather.descriptions}"),
      Text("Feels:${_weather.rFeels}*C"),
      Text("H:${_weather.high}*C L:${_weather.low}*C"),
    ]);
  }

  Future getCurrentWeather() async {
    Weather weather;
    String city = "St. Louis";
    //apiKey = "9b89af2c88ce9c7ac9a9f6200e249417"
    String apiKey = "9b89af2c88ce9c7ac9a9f6200e249417";
    var url =
        "https://api.openwathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      // TODO: Throw Error here
    }

    return weather;
  }
}
