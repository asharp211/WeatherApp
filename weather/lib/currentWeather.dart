import 'package:flutter/material.dart';
import 'screens/locations_details/location_details.dart';

class CurrentWeatherPage extends StatelessWidget{
  
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