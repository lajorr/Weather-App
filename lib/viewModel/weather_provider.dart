import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import '../model/current_weather.dart';

const String baseApi = 'http://api.weatherapi.com/v1';
const String apiKey = '5e84f9effc534a3ea12155644233103';

class WeatherProvider extends ChangeNotifier {
  CurrentWeather? _weatherData;

  String? _place;
  String? _errorMsg;

  String? get errorMsg {
    return _errorMsg;
  }

  CurrentWeather? get weatherData {
    return _weatherData;
  }

  void setPlace(String place) {
    _place = place;
  }

  void getData() async {
    print('ca;;');
    if (_place == null) {
      final locData = await Location().getLocation();
      _place = '${locData.latitude!},${locData.longitude!}';
    }
    final url = Uri.parse("$baseApi/current.json?key=$apiKey&q=$_place");
    // try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      // print(data);
      _weatherData = CurrentWeather(
        placeName: data['location']['name'],
        condition: data['current']['condition']['text'],
        temp: data['current']['temp_c'],
        icon: 'https:' + data['current']['condition']['icon'],
        feelsLike: data['current']['feelslike_c'],
        humidity: data['current']['humidity'],
        windKph: data['current']['wind_kph'],
        pressure: data['current']['pressure_mb'],
      );

      notifyListeners();
    } else {
      _errorMsg = "Invalid Place";
    }
  }

  // }
}
