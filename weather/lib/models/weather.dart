class Weather {
  // temp, real feel, lows, highs, descriptions, pressure, humidity, wind, icon
  final double temp;
  final double rFeels;
  final double low;
  final double high;
  final String description;
  final double pressure;
  final double humidity;
  final double wind;
  final String icon;


  Weather({
    this.temp = 0.0,
    this.rFeels = 0.0,
    this.low = 0.0, 
    this.high = 0.0,
    this.description = "",
    this.pressure = 0.0,
    this.humidity = 0.0,
    this.wind = 0.0,
    this.icon = "",
    });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      rFeels: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
