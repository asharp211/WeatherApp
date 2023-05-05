import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
          forcastViewsHourly(this.location),
          forcastViewsDaily(this.location),
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
          else{
            return Column(children: [
              createAppBar(location), //idea switching location createAppBar (locations, location, context),
              weatherBox(_weather),
              weatherDetailBox(_weather),
            ]);
          }
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
        future: getCurrentWeather(location),
    );
  }

  Widget forcastViewsHourly(Location location) {
    Forcast _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data;
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return hourlyBoxes(_forcast);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(location),
    );
  }

  Widget forcastViewsDaily(Location location) {
    Forcast _forcast;

    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _forcast = snapshot.data;
          if (_forcast == null) {
            return Text("Error getting weather");
          } else {
            return dailyBoxes(_forcast);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
      future: getForecast(location),
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
            borderRadius: BorderRadius.all(Radius.circular(20))),
        ),

        ClipPath(
          clipper: Clipper(),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            margin: const EdgeInsets.all(15.0),
            height: 160.0,
            decoration: BoxDecoration(
              color: Colors.indigoAccent[400],
              borderRadius: BorderRadius.all(Radius.circular(20))))
        ),

        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(15.0),
          height: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
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
      ]
    );
  }

  Widget weatherDetailBox(Weather _weather){
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 25, bottom: 25, right: 15),
      margin: const EdgeInsets.only(left: 15, top: 5, bottom: 15, right: 15),
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
                  "${_weather.humidity.toInt()}%",
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

  Widget hourlyBoxes(Forcast _forcast){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      height: 150.0,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 8, top: 0, bottom: 0, right: 8),
        scrollDirection: Axis.horizontal,
        itemCount: _forcast.hourly.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10, top: 15, bottom: 15, right: 10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ]
            ),

              child: Column(
                children: [
                  Text(
                    "${_forcast.hourly[index].temp}*",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Colors.black),
                  ),
                  getWeatherIcon(_forcast.hourly[index].icon),
                  Text(
                    "${getTimeFromTimestamp(_forcast.hourly[index].date)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey),
                  )
                ],
              ),
          );
          
        }
      )
    );
  }

  Widget dailyBoxes(Forcast _forcast){
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: 
        const EdgeInsets.only(left:8, top: 0, bottom:0, right:8),
        itemCount: _forcast.daily.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            padding: const EdgeInsets.only(
              left:10, top: 5, bottom:5, right:10),
              margin:  const EdgeInsets.all(5),
              child: Row(children: [
                Expanded(child: Text(
                  "${getDateFromTimestamp(_forcast.daily[index].date)}",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
                Expanded(child: 
                Text(
                  "${_forcast.daily[index].high.toInt()}/${_forcast.daily[index].low.toInt()}",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ))
              ]));
            }
      )
    );
  }

  Widget createAppBar(Location location){
    return Container(
      padding:
            const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
        margin: const EdgeInsets.only(
            top: 35, left: 15.0, bottom: 15.0, right: 15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(60)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              )
            ]),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: '${location.city.capitalizedFirstOfEach}, ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextSpan(
                  text: '${location.country.capitalizedFirstOfEach}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16)),
              ]
            )
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black,
            size: 24.0,
            semanticLabel: 'Tap to change location',
          ),
        ],
      )
    );
  }


  Future getCurrentWeather(Location location) async 
  {
    // TODO: Make API Key secured
    // Removing Null Safty by using late
    
    late Weather weather;
    String apiKey = "9b89af2c88ce9c7ac9a9f6200e249417";
    String city = location.city;
    String units = 'imperial';    

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
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  // Normal Icon
  Image getWeatherIcon(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 70,
      height: 70,
    );
  }

  // Small Icon
  Image getWeatherIconSmall(String _icon) {
    String path = 'assets/icons/';
    String imageExtension = ".png";
    return Image.asset(
      path + _icon + imageExtension,
      width: 40,
      height: 40,
    );
  }

}

class Clipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height - 20);

    path.quadraticBezierTo((size.width / 6) * 1, (size.height / 2) + 15, 
      (size.width / 3) * 1, size.height - 30);
    path.quadraticBezierTo((size.width / 2) * 1, (size.height + 0), 
      (size.width / 3) * 2, (size.height / 4) * 3);
    path.quadraticBezierTo((size.width / 6) * 5, (size.height / 2) - 20, 
      size.width, size.height - 60);
    
    path.lineTo(size.width, size.height - 60);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }
  @override
  bool shouldReclip(Clipper oldClipper) => false;
}

String getTimeFromTimestamp(int timestamp){
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('h:mm a');
  return formatter.format(date);
}

String getDateFromTimestamp(int timestamp){
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var formatter = new DateFormat('E');
  return formatter.format(date);
}