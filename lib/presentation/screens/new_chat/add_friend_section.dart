import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/presentation/components/buttons/colored_button.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_screen_model.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_view_model.dart';
import 'package:pillowtalk/presentation/screens/view_model_listener.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';

class AddFriendSection extends StatefulWidget {
  const AddFriendSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddFriendSectionState();
}

class _AddFriendSectionState extends State<AddFriendSection> with ViewModelListener {
  late NewChatViewModel viewModel;
  late NewChatScreenModel screenModel;
  final _controller = TextEditingController();

  _AddFriendSectionState() {
    viewModel = getIt.get<NewChatViewModel>();
    screenModel = viewModel.screenModel;
  }

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      var clearUsernameField = screenModel.clearUsernameFieldEvent?.data;
      if (clearUsernameField == true) _controller.clear();
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 6.0),
          decoration: BoxDecoration(
              color: context.getColor(colorSurface),
              borderRadius: BorderRadius.circular(materialCircularRadius)
          ),
          child: buildSearchField(context),
        ),
        ColoredButton(
          text: "Send request",
          onPress: viewModel.sendNewChatRequest,
          elevated: false,
          margin: const EdgeInsets.symmetric(vertical: materialSpacingSmall),
          isEnabled: !screenModel.loading,
        ),
        Text(
          screenModel.usernameSearchErrorMessage == null
              ? ""
              : "❗️${screenModel.usernameSearchErrorMessage}",
          style: Theme.of(context).textTheme.bodyText2?.adaptiveColor(
            context: context, color: colorError,
          ),
          textAlign: TextAlign.start,
        )
      ],
    );
  }

  Widget buildSearchField(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.adaptiveColor(context: context, color: colorOnBackground),
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search username",
          filled: true,
          fillColor: Colors.transparent,
          counter: const Offstage(),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(fontWeight: FontWeight.w100)
              .adaptiveColor(
            context: context,
            color: colorOnBackground,
            opacity: TextOpacity.medium,
          ),
          contentPadding: const EdgeInsets.all(materialSpacingRegular)
      ),
      onChanged: viewModel.usernameSearchTextChange,
      autocorrect: false,
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
    getIt.resetLazySingleton<NewChatViewModel>();
    super.dispose();
  }

  @override
  void onUpdateNotification() {
    setState(() {
      screenModel = viewModel.screenModel;
    });
  }
}
