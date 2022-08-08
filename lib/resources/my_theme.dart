import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pillowtalk/resources/my_colors.dart';

class MyTheme {
  static ThemeData getData({bool isNightMode = false}) {
    return isNightMode ? _darkMode : _lightMode;
  }

  static final ThemeData _lightMode = ThemeData(
    scaffoldBackgroundColor: colorScaffoldBackground.light,
    primarySwatch: Colors.indigo,
    textTheme: _textTheme,
  );

  static final ThemeData _darkMode = ThemeData(
    scaffoldBackgroundColor: colorScaffoldBackground.dark,
    primarySwatch: Colors.indigo,
    textTheme: _textTheme,
  );

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 95, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.poppins(
        fontSize: 59, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.poppins(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.poppins(
        fontSize: 20, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle1: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}
