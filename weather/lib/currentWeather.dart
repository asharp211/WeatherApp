import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/models/location.dart';
import 'dart:convert';
import 'package:weather/models/weather.dart';
import 'package:weather/models/forecast.dart';

class CurrentWeatherPage extends StatefulWidget {
  final List<Location> locations;
  const CurrentWeatherPage(this.locations);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState(this.locations);
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final List<Location> locations;
  // TODO: Change location or pick a location
  final Location location;
  Weather _weather;

  _CurrentWeatherPageState(List<Location> locations)
    : this.locations = locations, this.location = locations[0];

  @override
  // TODO: implement widget
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        children: <Widget> [
          currentWeatherViews(this.locations, this.location, this.context),
          forecastViewHourly(this.location),
          forecastViewDaily(this.location),
        ],
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

  Future getForecast(Location location) async {
    late Forcast forcast;

    String apiKey = "9b89af2c88ce9c7ac9a9f6200e249417";
    String lat = location.lat;
    String lon = location.lon;

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
              'lat': lat,
              'lon': lon,
              'appid': apiKey,
            });
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      forcast = Forcast.fromJson(jsonDecode(response.body));
    } else {
      // TODO: Throw Error here
      print('Request failed with status: ${response.statusCode}.');
    }
  }









}
