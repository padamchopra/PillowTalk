import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/platform_utils.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  const AdaptiveProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformUtils.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
