import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/home_screen.dart';

import '../viewModel/weather_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  Timer? timer2;
  bool isOverdue = false;
  @override
  void initState() {
    print('asd');
    toHome();

    // timer = Timer(duration, () { })
    timer = Timer(const Duration(seconds: 30), () {
      setState(() {
        isOverdue = true;
      });
    });
    timer2 = Timer.periodic(const Duration(seconds: 5), (timer) {
      toHome();
    });

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();

    timer2?.cancel();
    super.dispose();
  }

  void toHome() {
    Provider.of<WeatherProvider>(context, listen: false).getData();
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<WeatherProvider>(context).weatherData;

    if (data != null) {
      timer2?.cancel();
      return const HomeScreen();
    } else if (!isOverdue) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      timer2?.cancel();
      return Scaffold(
        body: AlertDialog(
          content: const Text(
            'Please turn on your gps for the app to work properly',
          ),
          actions: [
            TextButton(
              onPressed: () {
                toHome();
                timer2?.isActive;
              },
              child: const Text('Turn on'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }
}
