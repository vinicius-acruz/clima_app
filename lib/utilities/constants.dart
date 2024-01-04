import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'roboto',
  fontSize: 100.0,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'roboto',
  fontSize: 28.0,
  color: Colors.white,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'roboto',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.00),
      ),
      borderSide: BorderSide.none),
);

final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.transparent, // Transparent background
  side: BorderSide(color: Colors.white, width: 2), // White border
  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30), // Rounded corners
  ),
);
