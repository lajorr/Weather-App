import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewModel/forecast_weather_provider.dart';
import 'package:weather_app/viewModel/weather_provider.dart';
import 'package:weather_app/widgets/forecast/daily_forecast_widget.dart';
import 'package:weather_app/widgets/weather_info_widget.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() {
    final data =
        Provider.of<ForecastWeatherProvider>(context, listen: false).hourlyData;
    if (data.isEmpty) {
      Provider.of<ForecastWeatherProvider>(context, listen: false)
          .forcastApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: weather == null
            ? null
            : Text(
                weather.placeName,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: const [
              WeatherWidget(),
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: 'info',
                child: Material(
                  child: WeatherInfo(isDetailScreen: true),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // daily forecast widget
              DailyForecastWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
