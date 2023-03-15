/*
hourly, daily
*/

import 'package:weather/models/hourly.dart';
import 'package:weather/models/daily.dart';

class Forcast {
  final List<Hourly>? hourly;
  final List<Daily>? daily;

  Forcast({
    this.hourly,
    this.daily,    
  });

  factory Forcast.fromJson(Map<String, dynamic> json){
    List<dynamic> hourlyData = json['hourly'];
    List<dynamic> dailyData = json['daily'];

    List<Hourly> hourly = [];
    List<Daily> daily = [];

    hourlyData.forEach((element) {
      var hour = Hourly.fromJson(element);
      hourly.add(hour);
     });
    
    dailyData.forEach((element) {
      var day = Daily.fromJson(element);
      daily.add(day);
    });

    return Forcast(
      hourly: hourly,
      daily: daily,
    );
  }
}