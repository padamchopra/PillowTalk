import 'package:flutter/material.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';

class ColoredButton extends StatelessWidget {
  final String text;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final void Function() onPress;
  late final ColorSet color;
  late final ColorSet textColor;
  final bool elevated;
  final bool isEnabled;

  ColoredButton({
    super.key,
    required this.text,
    this.margin = const EdgeInsets.symmetric(
      horizontal: screenPadding,
      vertical: materialSpacingSmall
    ),
    this.padding = const EdgeInsets.symmetric(vertical: materialSpacingRegular),
    required this.onPress,
    this.elevated = false,
    ColorSet? color,
    ColorSet? textColor,
    this.isEnabled = true,
  }) {
    this.color = color ?? colorPrimary;
    this.textColor = textColor ?? colorOnPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPress : null,
        style: ElevatedButton.styleFrom(
          primary: context.getColor(color),
          onSurface: context.getColor(color).withAlpha(200),
          elevation: elevated ? null : 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: padding,
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.8,
            child: Text(
              text,
              style: Theme.of(context).textTheme.button?.adaptiveColor(
                  context: context,
                  color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
