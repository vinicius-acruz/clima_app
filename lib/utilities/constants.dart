import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'roboto',
  fontSize: 100.0,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'roboto',
  fontSize: 30.0,
  color: Colors.white,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
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
