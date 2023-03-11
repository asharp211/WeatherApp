import 'package:flutter/material.dart';
import 'package:weather/models/weather.dart';

class CurrentWeatherPage extends StatefulWidget{
  
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("My Weather App!")
      ),
    );
   }
}

Widget weatherBox(Weather _weather){
  return Column(
    children: <Widget>[
      Text("${_weather.temp}*C"),
      Text("${_weather.descriptions}"),
      Text("Feels:${_weather.rFeels}*C"),
      Text("H:${_weather.high}*C L:${_weather.low}*C"),
    ]
  );
}