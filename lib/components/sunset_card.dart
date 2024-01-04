import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart'; // Import the intl package

class SunriseSunsetWidget extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const SunriseSunsetWidget({
    Key? key,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white24, // Adjust the color to fit your theme
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Icon(Icons.wb_sunny, color: Colors.yellow),
              Text(
                'Sunrise: ${DateFormat('h:mm a').format(sunrise)}', // Use DateFormat from intl package
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              Lottie.asset('images/sunset.json'),
              Icon(Icons.nights_stay, color: Colors.blue),
              Text(
                'Sunset: ${DateFormat('h:mm a').format(sunset)}', // Use DateFormat from intl package
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
