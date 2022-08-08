import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool get isIOS {
    return (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS);
  }
}