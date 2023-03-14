
extension StringExtension on String{
  // Capitalized the first letter 
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizedFirstOfEach => this.split(" ").map((str) => str.inCaps).join(" ");

}