import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData(context);
  }

  void getLocationData(BuildContext context) async {
    try {
      WeatherModel weatherModel = WeatherModel();
      dynamic weatherData = await weatherModel.getLocationWeather();

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(locationWeather: weatherData);
      }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          // set container to take all screen space
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(color: Colors.white),
          child: Lottie.asset('images/loading_animation.json')),
    ));
  }
}
