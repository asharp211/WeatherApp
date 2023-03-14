/*
city,country latatude, longitude
*/
class Location{
  final String city;
  final String country;
  final String lat;
  final String lon;


    Location({
    this.city = "",
    this.country = "",
    this.lat = "", 
    this.lon = "",
    });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['main']['temp'].toDouble(),
      country: json['main']['feels_like'].toDouble(),
      lat: json['main']['temp_min'].toDouble(),
      lon: json['main']['temp_max'].toDouble(),
    );
  }


}