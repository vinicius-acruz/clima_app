import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:weather_icons/weather_icons.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);
  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        color: Colors.white30, // Set the color for the bottom sheet's container
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: kTextFieldInputDecoration,
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width * 0.7,
              child: OutlinedButton.icon(
                icon: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      WeatherIcons.cloud,
                      size: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ), // Using a weather icon
                label: Text(' Get Weather',
                    style: kButtonTextStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w400)),
                style: buttonStyle,
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
