import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

                // Removing the Null Safty by adding ? in front of the class
                Weather? _weather = snapshot.data;

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
        )
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
      Container(
        margin:  const EdgeInsets.all(10),
        child: Text("${_weather.temp.ceil()}°F",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),),
      ),
      Container(
        margin:  const EdgeInsets.all(10),
        child: Text("${_weather.description}")
        ),
      Container(
        margin:  const EdgeInsets.all(10),
        child: Text("Feels:${_weather.rFeels.ceil()}°F")
        ),
      Container(
        margin:  const EdgeInsets.all(10),
        child: Text("H:${_weather.high.ceil()}°F L:${_weather.low.ceil()}°F")
        ),
    ]
    );
  }

  Future getCurrentWeather() async {
    // Removing Null Safty by using late
    late Weather weather;
    String city = "St. Louis";
    //apiKey = "9b89af2c88ce9c7ac9a9f6200e249417"
    String apiKey = "9b89af2c88ce9c7ac9a9f6200e249417";
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
              'q': city,
              'appid': apiKey,
              'units': 'imperial',
            });
    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    } else {
      // TODO: Throw Error here
      print('Request failed with status: ${response.statusCode}.');
    }

    return weather;
  }
}
