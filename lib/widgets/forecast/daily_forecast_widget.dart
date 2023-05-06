// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/model/daily_weather.dart';
import 'package:weather_app/viewModel/forecast_weather_provider.dart';

class DailyForecastWidget extends StatelessWidget {
  const DailyForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Forecast',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Consumer<ForecastWeatherProvider>(
              builder: (context, value, _) {
                final data = value.dailyData;
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) => ForcastTile(
                    dailyWeatherData: data[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ForcastTile extends StatelessWidget {
  const ForcastTile({
    Key? key,
    required this.dailyWeatherData,
  }) : super(key: key);

  final DailyWeather dailyWeatherData;

  @override
  Widget build(BuildContext context) {
    final minTemp = dailyWeatherData.minTemp.toInt();
    final maxTemp = dailyWeatherData.maxTemp.toInt();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 30,
            child: Image.network(
              dailyWeatherData.icon,
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  dailyWeatherData.day,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  dailyWeatherData.condition,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$minTemp/$maxTemp',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
