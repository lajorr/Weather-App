// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyWeather {
  final String day;
  final double minTemp;
  final double maxTemp;
  final String icon;
  final String condition;
  DailyWeather({
    required this.day,
    required this.minTemp,
    required this.maxTemp,
    required this.icon,
    required this.condition,
  });
}
