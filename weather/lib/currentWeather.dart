import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/extentions.dart';
import 'package:weather/models/location.dart';
import 'dart:convert';
import 'extentions.dart';

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

  _CurrentWeatherPageState(List<Location> locations)
    : this.locations = locations, 
    this.location = locations[0];

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


  Widget currentWeatherViews(
    List<Location> locations, Location location, BuildContext context) {
      Weather _weather;

      return FutureBuilder(builder: (context, snapshot)
      {
        if(snapshot.hasData)
        {
          _weather = snapshot.data;
          if(_weather == null)
          {
            return Text("Error getting weather");
          }
          else
          {
            return Column(children: [
              //createAppBar(locations, location, context),
              weatherBox(_weather),
              //weatherDetailsBox(_weather),
            ]);
          }
        }
        else
        {
          return Center(child: CircularProgressIndicator());
        }
      },
        future: getCurrentWeather(location),
    );
  }

  Widget forecastViewHourly(Location location){
    Forcast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.hasData){
          _forcast = snapshot.data;

          if (_forcast == null){
            return Text("Error getting weather");
          } 
          else{
            //return hourlyBoxes(_forcast);
          }
        }
        else{
            return Center(child: CircularProgressIndicator());
          }
      },
      future: getForecast(location),
    );
  }

  Widget forecastViewDaily(Location location)
  {
    Forcast? _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {
          _forcast = snapshot.data;

          if(_forcast == null)
          {
            return Text("Error getting weather");
          }
          else{
            //return dailyBoxes(_forcast);
          }
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget weatherBox(Weather _weather){
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),

        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // TODO: Add Icons to Widget
                    getWeatherIcon(_weather.icon),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        "${_weather.description.capitalizedFirstOfEach}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.white),
                      )
                    ),

                    Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Text(
                        "H:${_weather.high.toInt()}° L:${_weather.low.toInt()}°",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Colors.white),
                        ),
                      )
                    ]
                  ),
                ),
                Column(
                  children: [
                    Container(
                      child: Text(
                        "${_weather.temp.toInt()}°",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                          color: Colors.white),
                          ),
                      ),

                    Container(
                      margin: const EdgeInsets.all(0),
                      child: Text(
                        "Feel like ${_weather.rFeels.toInt()}°",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color:  Colors.white),
                    ),
                  )
                ]
              ),
            ],
          )
        )
      ],
    ); 
  }

  Widget weatherDetailBox(Weather _weather)
  {
    return Container(
      padding: const EdgeInsets.only(left:15,
      top: 25,
      bottom: 25,
      right:15),
      margin: const EdgeInsets.only(left:15,
      top: 5,
      bottom: 15,
      right:15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0,3),
          )
        ]
      ),
      child: Row(
        children: [

          // Wind
          Expanded(
            child: Column(
              children: [
                Container(child: Text(
                  "Wind",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
                  )),
                  Container(
                    child: Text(
                      "${_weather.wind} mph",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                  )
              ],)),

          // Humidity
          Expanded(
            child: Column(
              children: [
                Container(child: Text(
                  "Humidity",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
                  )),
                  Container(
                    child: Text(
                      "${_weather.humidity.toInt()}%",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                  )
              ],)),

            //Pressure
            Expanded(
            child: Column(
              children: [
                Container(child: Text(
                  "Pressure",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.grey),
                  )),
                  Container(
                    child: Text(
                      "${_weather.pressure} PSI",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black
                      ),
                    ),
                  )
              ],))


      ],)
    );
  }

  Future getCurrentWeather(Location location) async 
  {
    // TODO: Make API Key secured

    // Removing Null Safty by using late
    
    late Weather weather;
    String city = "St. Louis";

    String units = 'imperial';
    String apiKey = "9b89af2c88ce9c7ac9a9f6200e249417";

    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
              'q': city,
              'appid': apiKey,
              'units': units,
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

  Future getForecast(Location location) async 
  {
    late Forcast forcast;

    String apiKey = "";
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

  // Normal Icon
  Image getWeatherIcon(String _icon)
  {
    String path = 'assets/weather/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
      );
  }

  // Small Icon
  Image getWeatherIconSmall(String _icon)
  {
    String path = 'assets/weather/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 30,
      height: 30,
      );
  }
}