import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewModel/weather_provider.dart';

class HomeWeatherWidget extends StatelessWidget {
  const HomeWeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weatherData;

    final currentTime = DateFormat('EEEE, d MMM h:mm a').format(
      DateTime.now(),
    );
    if (weather == null) {
      return const CircularProgressIndicator();
    } else {
      return Container(
        // height: 250,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Hero(
                  tag: 'weather icon',
                  child: Material(
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 100,
                        child: Image.network(
                          weather.icon,
                          fit: BoxFit.cover,
                          scale: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          weather.temp.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
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
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              weather.condition,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              currentTime,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }
  }
}
