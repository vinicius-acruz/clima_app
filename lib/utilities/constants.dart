import 'package:flutter/material.dart';

// Typography
const String kFontFamilyRoboto = 'roboto';

const double kFontSizeLarge = 80.0;
const double kFontSizeMedium = 30.0;
const double kFontSizeSmall = 25.0;

const kTempTextStyle = TextStyle(
  fontFamily: kFontFamilyRoboto,
  fontSize: kFontSizeLarge,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

const kMessageTextStyle = TextStyle(
  fontFamily: kFontFamilyRoboto,
  fontSize: kFontSizeMedium,
  color: Colors.white,
);

const kButtonTextStyle = TextStyle(
  fontSize: kFontSizeSmall,
  fontFamily: kFontFamilyRoboto,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: kFontSizeLarge,
);

// Input Decoration
const double kBorderRadiusValue = 10.0;

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
        Radius.circular(kBorderRadiusValue),
      ),
      borderSide: BorderSide.none),
);

// Button Styles
const double kButtonBorderWidth = 2.0;
const double kButtonPaddingHorizontal = 30.0;
const double kButtonPaddingVertical = 10.0;
const double kButtonBorderRadius = 30.0;

final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Colors.transparent,
  side: const BorderSide(color: Colors.white, width: kButtonBorderWidth),
  padding: const EdgeInsets.symmetric(
      horizontal: kButtonPaddingHorizontal, vertical: kButtonPaddingVertical),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(kButtonBorderRadius),
  ),
);
