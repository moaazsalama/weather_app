import 'package:flutter/material.dart';

extension NumExtension on num {
  //toCelcius
  double toCelcius() {
    return this - 273.15;
  }
  //toFahrenheit
  double toFahrenheit() {
    return (this - 273.15) * 9 / 5 + 32;
  }
  SizedBox get toSizedBoxWidthOnly => SizedBox(width: toDouble());
  SizedBox get toSizedBoxHeightOnly => SizedBox(height: toDouble());

}