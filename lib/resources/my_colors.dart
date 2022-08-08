import 'package:flutter/material.dart';

class ColorSet {
  final Color light;
  late Color dark;
  ColorSet({required this.light, dark}) {
    this.dark = dark ?? light;
  }
}

final colorScaffoldBackground = ColorSet(
    light: const Color.fromRGBO(244, 246, 250, 1.0),
    dark: Colors.black,
);
final colorOnBackground = ColorSet(light: Colors.black, dark: Colors.white);

final colorPrimary = ColorSet(
    light: const Color(0xFF3D5BCA),
    dark: const Color(0xFF5F7DCA),
);
final colorOnPrimary = ColorSet(light: Colors.white);

var colorSurface = ColorSet(light: Colors.white, dark: const Color(0xFF121212));
var colorOnSurface = ColorSet(light: Colors.black, dark: Colors.white);

final colorAccent = ColorSet(
    light: const Color(0xFFFEAB5F),
    dark: const Color(0xFFFECD82),
);

final colorError = ColorSet(light: Colors.red.shade500, dark: Colors.red.shade300);
