import 'package:clima/components/background_color.dart';
import 'package:clima/components/sunset_card.dart';
import 'package:clima/components/weather_info_card.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({required this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late IconData weatherIcon;
  late String weatherMessage;
  late String cityName;
  late String countryName;
  late String weatherDescription;
  late int humidity;
  late double windSpeed;
  late int visibility;
  late int pressure;
  late DateTime sunrise;
  late DateTime sunset;
  late WeatherModel weather = WeatherModel();

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = Icons.error;
        weatherMessage = 'Unable to get weather data';
        weatherDescription = '';
        cityName = '';
        countryName = '';
        humidity = 0;
        windSpeed = 0;
        visibility = 0;
        pressure = 0;
        return;
      } else {
        double temp = weatherData['main']['temp'];
        temperature = 21;
        //temp.toInt();
        weatherMessage = weather.getMessage(temperature);
        var condition = weatherData['weather'][0]['id'];
        weatherIcon = weather.getWeatherIcon(condition);
        cityName = weatherData['name'];
        countryName = weatherData['sys']['country'];
        weatherDescription = weatherData['weather'][0]['description'];
        humidity = weatherData['main']['humidity'];
        windSpeed = weatherData['wind']['speed'];
        visibility = weatherData['visibility'];
        pressure = weatherData['main']['pressure'];
        int sunriseTimestamp = weatherData['sys']['sunrise'];
        int sunsetTimestamp = weatherData['sys']['sunset'];
        sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000);
        sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000);

        print(weatherIcon);
        print(temperature);
        print(weatherMessage);
        print(cityName);
        print(weatherData);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              BackgroundColor.getBackgroundColor(temperature),
              Colors.white
            ])),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IntrinsicWidth(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: FittedBox(
                                    child: Text(
                                      '$cityName, $countryName',
                                      style: kMessageTextStyle.copyWith(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  thickness: 2,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          // Date widget
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Today ',
                                  style: TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                                  style: const TextStyle(
                                    fontSize: 23.0,
                                    fontWeight: FontWeight
                                        .bold, // change this to your desired weight
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              OutlinedButton(
                                onPressed: () async {
                                  dynamic weatherData =
                                      await weather.getLocationWeather();
                                  updateUI(weatherData);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors
                                      .transparent, // Transparent background
                                  shape: const CircleBorder(), // Circular shape
                                  side: const BorderSide(
                                      color: Colors.white, width: 2), // Border
                                  padding: const EdgeInsets.all(
                                      15), // Padding inside the button
                                  elevation: 5.0, // Shadow depth
                                ),
                                child: Icon(
                                  Icons.near_me,
                                  size: MediaQuery.of(context).size.width / 15,
                                ),
                              ),
                              const SizedBox(width: 5), // Space between buttons
                              OutlinedButton(
                                onPressed: () async {
                                  var typedName = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CityScreen()),
                                  );
                                  if (typedName != null) {
                                    var weatherData =
                                        await weather.getCityWeather(typedName);
                                    updateUI(weatherData);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors
                                      .transparent, // Transparent background
                                  shape: const CircleBorder(), // Circular shape
                                  side: const BorderSide(
                                      color: Colors.white, width: 2), // Border
                                  padding: const EdgeInsets.all(
                                      15), // Padding inside the button
                                  elevation: 5.0, // Shadow depth
                                ),
                                child: Icon(
                                  Icons.location_city,
                                  size: MediaQuery.of(context).size.width / 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Icon(weatherIcon, size: 80, color: Colors.white),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 5),
                    child: Text(
                      weatherMessage,
                      textAlign: TextAlign.justify,
                      style: kMessageTextStyle.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 25,
                    thickness: 2,
                    color: Colors.white,
                  ),
                  SunriseSunsetWidget(
                    sunrise: sunrise,
                    sunset: sunset,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 20, // Horizontal space between cards
                      runSpacing: 20, // Vertical space between rows
                      children: [
                        WeatherInfoCard(
                          title: 'Humidity',
                          value: '$humidity%',
                          icon: Icons.opacity,
                          temperature: temperature,
                        ),
                        WeatherInfoCard(
                          title: 'Wind',
                          value: '${windSpeed.toStringAsFixed(2)} km/h',
                          icon: Icons.wind_power,
                          temperature: temperature,
                        ),
                        WeatherInfoCard(
                          title: 'Visibility',
                          value: '${(visibility / 1000).toStringAsFixed(2)} km',
                          icon: Icons.remove_red_eye,
                          temperature: temperature,
                        ),
                        WeatherInfoCard(
                          title: 'Pressure',
                          value: '$pressure hPa',
                          icon: Icons.compress,
                          temperature: temperature,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
