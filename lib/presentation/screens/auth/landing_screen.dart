import 'package:flutter/material.dart';
import 'package:pillowtalk/presentation/components/buttons/colored_button.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_router.dart';
import 'package:pillowtalk/resources/my_strings.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  void navigateToAuthScreen(BuildContext context) {
    Navigator.pushNamed(context, Screens.authentication.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250.0,
              padding: const EdgeInsets.symmetric(horizontal: materialSpacingLarge),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  MyStrings.appEmojifiedName,
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            Text(
              "Pillow Talk",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.w900)
                  .adaptiveColor(context: context, color: colorOnBackground),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: materialSpacingRegular,
                horizontal: screenPadding,
              ),
              child: Text(
                "Text using automatic emojification\nwith personalised emoji secret phrases.",
                style: Theme.of(context).textTheme.bodyText1?.adaptiveColor(
                    context: context,
                    color: colorOnBackground,
                    opacity: TextOpacity.medium,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ColoredButton(
              margin: const EdgeInsets.fromLTRB(
                screenPadding,
                materialSpacingLarge,
                screenPadding,
                materialSpacingSmall,
              ),
              text: "Get Started",
              onPress: () => navigateToAuthScreen(context),
            ),
            ColoredButton(
                text: "I already have an account",
                onPress: () => navigateToAuthScreen(context),
                color: colorSurface,
                textColor: colorOnSurface,
            ),
          ],
        ),
      ),
    );
  }
}
