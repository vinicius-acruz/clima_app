import 'package:clima/components/background_color.dart';
import 'package:flutter/material.dart';

class WeatherInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final int temperature;

  const WeatherInfoCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width / 2 - 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, color: Colors.white, size: 30),
                  const SizedBox(height: 10),
                  Text(title,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
          ),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
