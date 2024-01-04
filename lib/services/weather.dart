import 'package:clima/keys/env.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
  static String apiKey = Env.openWeatherkey1;
  static const openWeatherMapURL =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&units=metric&appid=$apiKey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition < 400) {
      return WeatherIcons.showers;
    } else if (condition < 600) {
      return WeatherIcons.rain;
    } else if (condition < 700) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.fog;
    } else if (condition == 800) {
      return WeatherIcons.day_sunny;
    } else if (condition <= 804) {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons.na;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s a great day for ice cream!';
    } else if (temp > 20) {
      return 'Perfect weather for shorts and t-shirts.';
    } else if (temp < 10) {
      return 'It\'s quite cold, consider wearing a scarf and gloves.';
    } else {
      return 'A bit chilly, you might want to bring a jacket.';
    }
  }
}
