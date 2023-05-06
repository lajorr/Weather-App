// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrentWeather {
  final String placeName;
  final String condition;
  final double temp;
  final String icon;
  final double feelsLike;
  final double windKph;
  final int humidity;
  final double pressure;
  CurrentWeather({
    required this.placeName,
    required this.condition,
    required this.temp,
    required this.icon,
    required this.feelsLike,
    required this.windKph,
    required this.humidity,
    required this.pressure,
  });
}
