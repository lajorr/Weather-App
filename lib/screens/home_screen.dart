import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/home_weather_widget.dart';

import '../viewModel/weather_provider.dart';
import '../widgets/weather_info_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  void callApi() {
    final data =
        Provider.of<WeatherProvider>(context, listen: false).weatherData;
    if (data == null) {
      Provider.of<WeatherProvider>(context, listen: false).getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<WeatherProvider>(context).weatherData;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          // on press garyo vane places search garne ani tyo place ko api call
          onPressed: () {},
          icon: const Icon(
            Icons.search,
          ),
        ),
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              HomeWeatherWidget(),
              Hero(
                tag: 'info',
                child: Material(
                  child: WeatherInfo(
                    isDetailScreen: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
