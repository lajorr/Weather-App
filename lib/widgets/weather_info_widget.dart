// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/screens/weather_details_screen.dart';
import 'package:weather_app/viewModel/weather_provider.dart';
import 'package:weather_app/widgets/forecast/hourly_forecast_widget.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    Key? key,
    required this.isDetailScreen,
  }) : super(key: key);

  final bool isDetailScreen;

  @override
  Widget build(BuildContext context) {
    void moreInfo() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const WeatherDetailsScreen(),
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: isDetailScreen ? null : moreInfo,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          // height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isDetailScreen == false)
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    'More Info',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              SizedBox(
                height: isDetailScreen ? 200 : 280,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: isDetailScreen ? 1.75 : 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return isDetailScreen
                        ? DetailsWidget(index: index)
                        : HomeWidget(index: index);
                  },
                ),
              ),
              if (isDetailScreen)
                Column(
                  children: const [
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 35,
                      endIndent: 35,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HourlyForecastWidget(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

const List iconList = [
  ['assets/images/thermometer.png', 'Feels Like'],
  ['assets/images/wind.png', 'Wind Speed'],
  ['assets/images/pressure.png', 'Pressure'],
  ['assets/images/humidity.png', 'Humidity'],
];

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            // spreadRadius: 1,
            blurRadius: 5,
            // spreadRadius: 1,
            // blurStyle: BlurStyle.outer,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              iconList[index][0],
            ),
            Text(
              iconList[index][1],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            Consumer<WeatherProvider>(
              builder: (context, value, _) {
                final weather = value.weatherData;
                if (weather == null) {
                  return Container();
                }

                List weatherInfo = [
                  '${weather.feelsLike} °C',
                  '${weather.windKph} km/h',
                  '${weather.pressure} mbar',
                  '${weather.humidity} %',
                ];
                return Text(
                  weatherInfo[index],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            // spreadRadius: ,
            blurRadius: 5,
            // spreadRadius: 1,
            // blurStyle: BlurStyle.outer,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              iconList[index][0],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  iconList[index][1],
                  style: const TextStyle(
                    // fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Consumer<WeatherProvider>(
                  builder: (context, value, _) {
                    final weather = value.weatherData;

                    List weatherInfo = [
                      '${weather!.feelsLike} °C',
                      '${weather.windKph} km/h',
                      '${weather.pressure} mbar',
                      '${weather.humidity} %',
                    ];
                    return Text(
                      weatherInfo[index],
                      style: const TextStyle(
                        // fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
