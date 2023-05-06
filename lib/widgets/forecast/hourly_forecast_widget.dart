// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/model/hourly_weather.dart';

import '../../viewModel/forecast_weather_provider.dart';

class HourlyForecastWidget extends StatelessWidget {
  const HourlyForecastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '   Hourly Forecast',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Consumer<ForecastWeatherProvider>(
            builder: (context, value, _) {
              final hourData = value.hourlyData;
              final dataLen = hourData.length;

              return dataLen == 0
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: dataLen,
                      scrollDirection: Axis.horizontal,
                      physics: const PageScrollPhysics(),
                      // padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, index) {
                        return HourWidget(
                          hourData: hourData[index],
                        );
                      },
                    );
            },
          ),
        ),
      ],
    );
  }
}

class HourWidget extends StatelessWidget {
  const HourWidget({
    Key? key,
    required this.hourData,
  }) : super(key: key);
  final HourlyWeather hourData;

  @override
  Widget build(BuildContext context) {
    String meridian = 'AM';
    int time = int.parse(hourData.time);
    if (time > 12) {
      time = time - 12;
      meridian = 'PM';
    }

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        left: 5,
        right: 5,
        bottom: 15,
        top: 5,
      ),
      height: 100,
      width: 75,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            // spreadRadius: 1,
            blurRadius: 5,
            // spreadRadius: 1,
            blurStyle: BlurStyle.normal,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time.toString() + meridian,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey[300],
            child: Image.network(
              hourData.icon,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            "${hourData.temp}°",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
