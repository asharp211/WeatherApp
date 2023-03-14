/*
hourly, daily
*/

import 'package:weather/models/hourly.dart';
import 'package:weather/models/daily.dart';

class forcast {
  final List<Hourly>? hourly;
  final List<Daily>? daily;

  forcast({
    this.hourly,
    this.daily,    
  });

  factory forcast.fromJson(Map<String, dynamic> json){
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

    return forcast(
      hourly: hourly,
      daily: daily,
    );
  }
}