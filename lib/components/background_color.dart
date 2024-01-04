import 'package:flutter/material.dart';

class BackgroundColor {
  static Color lerpColor(Color start, Color end, double fraction) {
    return Color.lerp(start, end, fraction)!;
  }

  static Color getBackgroundColor(int temp) {
    if (temp < 0) {
      // Solid Blue for temperatures below 0
      return const Color.fromRGBO(27, 177, 255, 1);
    } else if (temp >= 0 && temp < 20) {
      // Interpolating between specific shades of blue
      Color startBlue = const Color.fromRGBO(27, 177, 255, 1);
      Color endBlue = const Color.fromRGBO(161, 223, 255, 1);
      double fraction = temp / 20;
      return lerpColor(startBlue, endBlue, fraction);
    } else if (temp >= 20 && temp < 40) {
      // Interpolating between specific shades of red
      Color startRed = temp == 20
          ? const Color.fromRGBO(27, 177, 255, 1)
          : const Color.fromRGBO(255, 102, 102, 1); // Blue at 20, Red otherwise
      Color endRed = const Color.fromRGBO(214, 0, 0, 1);
      double fraction = (temp - 20) / 20;
      return lerpColor(startRed, endRed, fraction);
    } else {
      // Solid Red for temperatures above 40
      return const Color.fromRGBO(214, 0, 0, 1);
    }
  }
}
