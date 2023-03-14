import 'package:flutter/material.dart';
import 'package:weather/models/location.dart';
import 'currentWeather.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Working on set own location or GPS Location
  List<Location> location = [
    new Location(city: "St. Louis", country: "United States", lat: "38.6273", lon: "-90.1979")
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurrentWeatherPage(),
    );
  }
}
