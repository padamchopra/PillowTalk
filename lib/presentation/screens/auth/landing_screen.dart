import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/presentation/components/adaptive_progress_indicator.dart';
import 'package:pillowtalk/presentation/components/buttons/colored_button.dart';
import 'package:pillowtalk/presentation/screens/auth/auth_view_model.dart';
import 'package:pillowtalk/presentation/screens/auth/landing_screen_model.dart';
import 'package:pillowtalk/presentation/screens/auth/landing_view_model.dart';
import 'package:pillowtalk/presentation/screens/view_model_listener.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_router.dart';
import 'package:pillowtalk/resources/my_strings.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with ViewModelListener {
  late LandingViewModel viewModel;
  late LandingScreenModel screenModel;

  _LandingScreenState() {
    viewModel = getIt.get<LandingViewModel>();
    screenModel = viewModel.screenModel;
  }
  void navigateToAuthScreen(BuildContext context, bool freshStart) {
    var formStep = screenModel.updateFormStepEvent?.data;
    if (formStep != null && !freshStart) {
      getIt.get<AuthViewModel>().handleStateStepChange(formStep);
    }
    Navigator.pushNamed(context, Screens.authentication.name);
  }

  @override
  Widget build(BuildContext context) {
    final navigateEvent = screenModel.navigateScreenEvent?.data;
    if (navigateEvent != null) {
      Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context, navigateEvent.name, (route) => false,
      ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: screenModel.loading ? const Center(
          child: AdaptiveProgressIndicator(),
        ) : Column(
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
              onPress: () => navigateToAuthScreen(context, true),
            ),
            ColoredButton(
              text: "I already have an account",
              onPress: () => navigateToAuthScreen(context, false),
              color: colorSurface,
              textColor: colorOnSurface,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.addListener(this);
  }

  @override
  void dispose() {
    viewModel.removeListener(this);
    getIt.resetLazySingleton<LandingViewModel>();
    super.dispose();
  }

  @override
  void onUpdateNotification() {
    setState(() {
      screenModel = viewModel.screenModel;
    });
  }
}
