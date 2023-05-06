import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/daily_weather.dart';

import '../model/hourly_weather.dart';

const String baseApi = 'http://api.weatherapi.com/v1';
const String apiKey = '5e84f9effc534a3ea12155644233103';

const daysList = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
];

class ForecastWeatherProvider extends ChangeNotifier {
  List<HourlyWeather> _hourlyData = [];
  List<DailyWeather> _dailyData = [];

  List<HourlyWeather> get hourlyData {
    return _hourlyData;
  }

  List<DailyWeather> get dailyData {
    return _dailyData;
  }

  String? _place;

  void callForecastApi() {}

  String stringSplice(String time) {
    final str = time;
    const start = " ";
    const end = ":";

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end, startIndex + start.length);

    return str.substring(startIndex + start.length, endIndex);
  }

  void forcastApi() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    if (_place == null) {
      final locData = await Location().getLocation();
      _place = '${locData.latitude!},${locData.longitude!}';
    }
    final url =
        Uri.parse("$baseApi/forecast.json?key=$apiKey&q=$_place&days=3");
    // try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // print(data);

      final dayList = data['forecast']['forecastday'] as List<dynamic>;
      final currentDay =
          dayList.firstWhere((element) => element['date'] == formattedDate);

      final hourList = currentDay['hour'] as List<dynamic>;

      final hourIndex = int.parse(
        DateFormat('HH').format(now),
      );

      storeHourlyData(hourIndex, hourList);
      storeDailyData(hourIndex, dayList);

      notifyListeners();
    } else {
      print('error hour');
    }
  }

  void storeHourlyData(int index, List<dynamic> hourList) {
    _hourlyData = [];

    int j;
    // this works cz in the api the first index([0]) is the data of time 00:00 and similarly 2nd index is of 01:00
    //so all we need to do is get the current hour and that will be the required index
    // print(hourList[index]); // current hour ko data

    for (var i = index + 1; i < (index + 24); i++) {
      if (i >= 24) {
        j = i - 24;
      } else {
        j = i;
      }

      final formattedTime = stringSplice(
        hourList[j]["time"],
      );
      _hourlyData.add(
        HourlyWeather(
          time: formattedTime,
          temp: hourList[j]['temp_c'],
          icon: "https:" + hourList[j]['condition']['icon'],
        ),
      );
    }
  }

  void storeDailyData(int index, List<dynamic> dayList) {
    _dailyData = [];
    String dayText;
    // final dayData = dayList[0]['day'];
    // print(dayData);
    final day = DateFormat('EEEE').format(
      DateTime.now(),
    );
    int currentDayIndex = daysList.indexOf(day);
    print(currentDayIndex);

    for (var i = 0; i < 3; i++) {
      final dayData = dayList[i]['day'];
      switch (i) {
        case 0:
          {
            dayText = 'Today';
            break;
          }
        case 1:
          {
            dayText = 'Tomorrow';
            break;
          }
        default:
          {
            dayText = daysList[currentDayIndex + i];
          }
      }
      _dailyData.add(
        DailyWeather(
          day: dayText,
          minTemp: dayData['mintemp_c'],
          maxTemp: dayData['maxtemp_c'],
          icon: "https:" + dayData['condition']['icon'],
          condition: dayData['condition']['text'],
        ),
      );
    }
  }
}
