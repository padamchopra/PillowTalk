import 'package:flutter/cupertino.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';

enum TextOpacity { bare, low, medium, normal }

extension TextOpacityProperties on TextOpacity {
  double get value {
    switch (this) {
      case TextOpacity.bare:
        return 0.1;
      case TextOpacity.low:
        return 0.4;
      case TextOpacity.medium:
        return 0.6;
      case TextOpacity.normal:
        return 1;
    }
  }
}


extension TextStyleProperties on TextStyle {
  TextStyle adaptiveColor({
    required BuildContext context,
    ColorSet? color,
    TextOpacity opacity = TextOpacity.normal
  }) {
    return copyWith(
      color: context.getColor(color ?? colorOnBackground).withOpacity(opacity.value)
    );
  }
}
