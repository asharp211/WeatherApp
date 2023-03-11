class Weather {
  // temp, real feel, lows, highs, descriptions
  final double temp;
  final double rFeels;
  final double low;
  final double high;
  final String descriptions;

  Weather({this.temp, this.rFeels, this.low, this.high, this.descriptions});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      rFeels: json['main']['rFeels'].toDouble(),
      low: json['main']['low'].toDouble(),
      high: json['main']['high'].toDouble(),
      descriptions: json['weather'][0]['descriptions'],
    );
  }
}
