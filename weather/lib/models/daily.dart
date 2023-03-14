/*
date,feelssLike,low,high,description,pressure,humidity,wind,icon
 */

class Daily{
  final int date;
  final double temp;
  final double rFeels;
  final double low;
  final double high;
  final double pressure;
  final double humidity;
  final double wind;
  final String description;
  final String icon;

  Daily({
    this.date = 0,
    this.temp = 0.0,
    this.rFeels = 0.0,
    this.low = 0.0,
    this.high = 0.0,
    this.pressure = 0.0,
    this.humidity = 0.0,
    this.wind = 0.0,
    this.description = "",
    this.icon = "",

  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      date: json['main']['dt'],
      temp: json['main']['temp'].toDouble(),
      rFeels: json['main']['feels_like'].toDouble(),
      low: json['main']['min'].toDouble(),
      high: json['main']['max'].toDouble(),      
      pressure: json['main']['pressure'].toDouble(),
      humidity: json['main']['humidity'].toDouble(),
      wind: json['main']['wind_speed'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }

}