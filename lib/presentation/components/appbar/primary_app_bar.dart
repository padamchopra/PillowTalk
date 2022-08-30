import 'package:flutter/material.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';

class PrimaryAppBar {
  static AppBar build({
    required BuildContext context,
    String? title,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: screenPadding,
      leading: leading,
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.subtitle1?.adaptiveColor(
            context: context, color: colorOnPrimary
        ).copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: false,
      actions: actions,
      elevation: 1,
      backgroundColor: context.getColor(colorPrimary),
    );
  }
}
