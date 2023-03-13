class Weather {
  // temp, real feel, lows, highs, descriptions
  final double temp;
  final double rFeels;
  final double low;
  final double high;
  final String descriptions;

  Weather({
    this.temp = 0.0,
    this.rFeels = 0.0,
    this.low = 0.0, 
    this.high = 0.0,
    this.descriptions = "",
    });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      rFeels: json['main']['feels_like'].toDouble(),
      low: json['main']['temp_min'].toDouble(),
      high: json['main']['temp_max'].toDouble(),
      descriptions: json['weather'][0]['description'],
    );
  }
}
