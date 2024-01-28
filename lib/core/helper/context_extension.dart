import 'package:flutter/material.dart';

extension ContextHELP on BuildContext {
  double calcilateResponsiveFontSize(double fontSize) {
    return fontSize * (width / 414);
  }

  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  //textThem
  TextTheme get textTheme => Theme.of(this).textTheme;
// double get height => MediaQuery.of(this).size.height;
  // double get width => MediaQuery.of(this).size.width;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  Orientation get orientation => MediaQuery.of(this).orientation;
  // Sizes - Helpers
  double propHeight(double inputHeight) => (inputHeight / 872) * height;
  double propWidth(double inputWidth) => (inputWidth / 417) * width;
  

  // Theme
  ThemeData get theme => Theme.of(this);
}
