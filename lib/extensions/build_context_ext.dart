import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_colors.dart';

extension BuildContextProperties on BuildContext {
  Color getColor(ColorSet color) {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? color.light
        : color.dark;
  }

  Color getColorWithOpacity(ColorSet color, TextOpacity opacity) {
    return MediaQuery.of(this).platformBrightness == Brightness.light
        ? color.light.withOpacity(opacity.value)
        : color.dark.withOpacity(opacity.value);
  }
}
