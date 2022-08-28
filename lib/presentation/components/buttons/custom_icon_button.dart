import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_colors.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  final String tooltip;

  const CustomIconButton({
    Key? key,
    this.onPressed,
    required this.iconData,
    required this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: context.getColorWithOpacity(colorOnPrimary, TextOpacity.medium),
      ),
      tooltip: tooltip,
      splashRadius: Theme.of(context).iconTheme.size ?? 14 * 1.5,
    );
  }
}
