import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart'; // Import the intl package

class SunriseSunsetWidget extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;

  const SunriseSunsetWidget({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

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
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Lottie.asset('images/sunrise.json')),
              Text(
                'Sunrise: ${DateFormat('h:mm a').format(sunrise)}', // Use DateFormat from intl package
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Lottie.asset('images/sunset.json')),
              Text(
                'Sunset: ${DateFormat('h:mm a').format(sunset)}', // Use DateFormat from intl package
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
