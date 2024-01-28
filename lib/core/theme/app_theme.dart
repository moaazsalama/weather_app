import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get theme => ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(textTheme(Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        brightness: Brightness.light,
      );
  static ThemeData get darkTheme => ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(textTheme(Colors.white)),

        iconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
      );
  static TextTheme textTheme(Color textColor) => TextTheme(
        //set the common text style here
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        labelLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        labelMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        labelSmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        displayLarge: GoogleFonts.poppins(
          fontSize: 96,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        displayMedium: GoogleFonts.poppins(
          fontSize: 60,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        displaySmall: GoogleFonts.poppins(
          fontSize: 48,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 34,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        titleMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        titleSmall: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      );
}
