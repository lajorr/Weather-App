// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewModel/weather_provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weatherData;
    if (weather == null) {
      return const CircularProgressIndicator();
    } else {
      return Container(
        // height: 250,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: "weather icon",
                  child: Material(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 75,
                      child: Image.network(
                        weather.icon,
                        fit: BoxFit.cover,
                        scale: 0.5,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          width: 105,
                          child: Text(
                            "Tap to change to fahrenheit scale",
                            style: TextStyle(
                                color: Colors.grey,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              weather.temp.toInt().toString(),
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const SizedBox(
                              height: 20,
                              width: 20,
                              child: Text(
                                "°",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            weather.condition,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
