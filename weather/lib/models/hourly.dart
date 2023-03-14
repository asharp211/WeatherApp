/*
temp, feelsLike, pressure, dewPoint, uvi, visibility, wind, description, icon
*/

class Hourly{
  final int date;
  final double temp;
  final double rFeels;
  final double pressure;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final double visibility;
  final double wind;
  final String description;
  final String icon;

  Hourly({
    this.date = 0,
    this.temp = 0.0,
    this.rFeels = 0.0,
    this.pressure = 0.0,
    this.dewPoint = 0.0,
    this.uvi = 0.0,
    this.clouds = 0,
    this.visibility = 0.0,
    this.wind = 0.0,
    this.description = "",
    this.icon = "",

  });

  factory Hourly.fromJson(Map<String, dynamic> json) {
    return Hourly(
      date: json['main']['dt'],
      temp: json['main']['temp'].toDouble(),
      rFeels: json['main']['feels_like'].toDouble(),
      pressure: json['main']['pressure'].toDouble(),
      dewPoint: json['main']['dew_point'].toDouble(),
      uvi: json['main']['uvi'].toDouble(),
      clouds: json['main']['clouds'],
      visibility: json['main']['visibility'].toDouble(),
      wind: json['main']['wind_speed'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }

}