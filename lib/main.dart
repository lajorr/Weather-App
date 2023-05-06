import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/viewModel/forecast_weather_provider.dart';

import 'viewModel/weather_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ForecastWeatherProvider(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        title: "FlutterApp",
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
        home: const SplashScreen(),
      ),
    );
  }
}
