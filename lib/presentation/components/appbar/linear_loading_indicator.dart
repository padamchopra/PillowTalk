import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';

class LinearLoadingIndicator extends StatelessWidget {
  final bool loading;

  const LinearLoadingIndicator({
    Key? key,
    required this.loading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: loading ? LinearProgressIndicator(
        color: context.getColor(colorAccent),
        backgroundColor: context.getColorWithOpacity(
            colorPrimary,
            TextOpacity.medium
        ),
      ) : Container(),
    );
  }
}
