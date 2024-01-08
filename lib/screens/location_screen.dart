import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/components/background_color.dart';
import 'package:clima/components/weather_info_card.dart';
import 'package:clima/components/sunset_card.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;
  const LocationScreen({super.key, required this.locationWeather});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with SingleTickerProviderStateMixin {
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

  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);

    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _topAlignmentAnimation = Tween<Alignment>(
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ).animate(curvedAnimation);

    _bottomAlignmentAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topRight,
    ).animate(curvedAnimation);

    _controller.repeat(reverse: true);
  }

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
        temperature = temp.toInt();
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
      }
    });
  }

  Widget _buildWeatherInfoRow() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(weatherIcon, size: 75, color: Colors.white),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(width: 30),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Text('$temperature°', style: kTempTextStyle)),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.36,
              child: FittedBox(
                child: Text(
                  weatherDescription,
                  style: kMessageTextStyle.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 25,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        OutlinedButton(
          onPressed: () async {
            dynamic weatherData = await weather.getLocationWeather();
            updateUI(weatherData);
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            side: const BorderSide(color: Colors.white, width: 2),
            padding: const EdgeInsets.all(15),
            elevation: 5.0,
          ),
          child:
              Icon(Icons.near_me, size: MediaQuery.of(context).size.width / 15),
        ),
        const SizedBox(width: 5),
        OutlinedButton(
          onPressed: () async {
            var typedName = await showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.5),
              builder: (BuildContext context) {
                return const CityScreen();
              },
            );
            if (typedName != null) {
              var weatherData = await weather.getCityWeather(typedName);
              updateUI(weatherData);
            }
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            shape: const CircleBorder(),
            side: const BorderSide(color: Colors.white, width: 2),
            padding: const EdgeInsets.all(15),
            elevation: 5.0,
          ),
          child: Icon(Icons.location_city,
              size: MediaQuery.of(context).size.width / 15),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicWidth(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: FittedBox(
                            child: Text(
                              '$cityName, $countryName',
                              textAlign: TextAlign.left,
                              style: kMessageTextStyle.copyWith(
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        const Divider(
                            height: 00, thickness: 2, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Today ',
                          style: TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        TextSpan(
                          text:
                              '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}',
                          style: const TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              _buildButtonRow(),
            ],
          ),
          _buildWeatherInfoRow(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width / 5),
            child: Text(
              weatherMessage,
              textAlign: TextAlign.justify,
              style: kMessageTextStyle.copyWith(fontWeight: FontWeight.w300),
            ),
          ),
          const Divider(height: 25, thickness: 2, color: Colors.white),
          SunriseSunsetWidget(sunrise: sunrise, sunset: sunset),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15)),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20, // Horizontal space between cards
              runSpacing: 10, // Vertical space between rows
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: _topAlignmentAnimation.value,
                    end: _bottomAlignmentAnimation.value,
                    colors: [
                  BackgroundColor.getBackgroundColor(temperature),
                  Colors.white70
                ])),
            child: SafeArea(bottom: false, child: _buildMainContent()),
          );
        },
      ),
    );
  }
}
