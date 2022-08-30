import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/icon_data_ext.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/presentation/components/appbar/linear_loading_indicator.dart';
import 'package:pillowtalk/presentation/components/appbar/primary_app_bar.dart';
import 'package:pillowtalk/presentation/components/buttons/custom_icon_button.dart';
import 'package:pillowtalk/presentation/screens/new_chat/add_friend_section.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_screen_model.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_view_model.dart';
import 'package:pillowtalk/presentation/screens/view_model_listener.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> with ViewModelListener {
  late NewChatViewModel viewModel;
  late NewChatScreenModel screenModel;

  _NewChatScreenState() {
    viewModel = getIt.get<NewChatViewModel>();
    screenModel = viewModel.screenModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenPadding),
              child: AddFriendSection(),
            ),
          ),
          LinearLoadingIndicator(loading: screenModel.loading)
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return PrimaryAppBar.build(
      context: context,
      title: "New chat 🆕💬",
      leading: CustomIconButton(
          onPressed: () => Navigator.pop(context),
          iconData: IconChooser.adaptive(
            android: Icons.arrow_back, 
            ios: Icons.arrow_back_ios_new,
          ), 
          tooltip: "Back",
      )
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
