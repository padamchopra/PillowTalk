import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/platform_utils.dart';

class IconChooser {
  static IconData adaptive({
    required IconData android,
    required IconData ios,
  }) {
    return PlatformUtils.isIOS
        ? ios
        : android;
  }
}
