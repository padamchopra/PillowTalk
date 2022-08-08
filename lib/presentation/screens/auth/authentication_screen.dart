import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/presentation/components/adaptive_progress_indicator.dart';
import 'package:pillowtalk/presentation/components/buttons/colored_button.dart';
import 'package:pillowtalk/presentation/screens/auth/auth_screen_models.dart';
import 'package:pillowtalk/presentation/screens/auth/auth_view_model.dart';
import 'package:pillowtalk/presentation/screens/view_model_listener.dart';
import 'package:pillowtalk/extensions/icon_data_ext.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> with ViewModelListener {
  late AuthViewModel viewModel;
  late AuthScreenModel screenModel;

  _AuthenticationScreenState() {
    viewModel = getIt.get<AuthViewModel>();
    screenModel = viewModel.screenModel;
  }

  @override
  Widget build(BuildContext context) {
    final navigateEvent = screenModel.navigateEvent?.data;
    if (navigateEvent != null) {
      Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context, navigateEvent.name, (route) => false,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: screenModel.loading
              ? null
              : () => { Navigator.pop(context) },
          icon: Icon(
            IconChooser.adaptive(
                android: Icons.arrow_back,
                ios: Icons.arrow_back_ios_new,
            ),
            color: context.getColor(colorOnBackground),
          ),
          splashRadius: Theme.of(context).iconTheme.size ?? 14 * 1.5,

        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: screenPadding),
        //       child: Align(
        //         alignment: Alignment.center,
        //         child: Text(
        //           "${screenModel.currentField.index+1}/${screenModel.formModels.length}",
        //           style: Theme.of(context).textTheme.bodyText1?.adaptiveColor(
        //               context: context,
        //               color: colorOnBackground
        //           ),
        //         ),
        //       )
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Stack(
          children: [
            screenModel.loading ? const Center(
              child: AdaptiveProgressIndicator(),
            ) : Container(),
            IndexedStack(
              index: screenModel.currentField.index < screenModel.formModels.length
                  ? screenModel.currentField.index
                  : 0,
              children: screenModel.formModels.map((e) => formBuilder(e)).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget formBuilder(AuthScreenFormModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(fontWeight: FontWeight.w900)
                  .adaptiveColor(context: context, color: colorOnBackground),
            ),
            const SizedBox(height: materialSpacingSmall, width: double.infinity,),
            Text(
              model.subtitle,
              style: Theme.of(context).textTheme.bodyText1?.adaptiveColor(
                  context: context,
                  color: colorOnBackground,
                  opacity: TextOpacity.medium,
              ),
            ),
            const SizedBox(
                height: materialSpacingLarge, width: double.infinity),
            TextFormField(
              keyboardType: model.textInputType,
              maxLines: 1,
              maxLength: model.maxLength,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.adaptiveColor(context: context, color: colorOnBackground),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: model.placeholder,
                counter: const Offstage(),
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontWeight: FontWeight.w100)
                    .adaptiveColor(
                      context: context,
                      color: colorOnBackground,
                      opacity: TextOpacity.medium,
                    ),
              ),
              onChanged: viewModel.onInputChange,
              autocorrect: false,
              autofillHints: model.autofillHints,
              obscureText: model.obscureText,
            ),
            Text(
              model.error != null ? "❗️${model.error}" : "",
              style: Theme.of(context).textTheme.bodyText2?.adaptiveColor(
                  context: context, color: colorError,
              )
            ),
          ],
        ),
        ColoredButton(
          margin: const EdgeInsets.only(bottom: materialSpacingRegular),
          text: model.button,
          onPress: viewModel.onButtonClick,
          isEnabled: model.buttonEnabled && !screenModel.loading,
        )
      ],
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
    getIt.resetLazySingleton<AuthViewModel>();
    super.dispose();
  }

  @override
  void onUpdateNotification() {
    setState(() {
      screenModel = viewModel.screenModel;
    });
  }
}
