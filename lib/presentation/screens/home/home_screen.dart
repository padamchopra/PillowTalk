import 'package:flutter/material.dart';
import 'package:pillowtalk/extensions/text_style_ext.dart';
import 'package:pillowtalk/extensions/build_context_ext.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/presentation/components/adaptive_progress_indicator.dart';
import 'package:pillowtalk/presentation/components/buttons/custom_icon_button.dart';
import 'package:pillowtalk/presentation/screens/home/chat_tile_model.dart';
import 'package:pillowtalk/presentation/screens/home/home_screen_model.dart';
import 'package:pillowtalk/presentation/screens/home/home_view_model.dart';
import 'package:pillowtalk/presentation/screens/view_model_listener.dart';
import 'package:pillowtalk/resources/my_colors.dart';
import 'package:pillowtalk/resources/my_dimensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ViewModelListener {
  late HomeViewModel viewModel;
  late HomeScreenModel screenModel;

  _HomeScreenState() {
    viewModel = getIt.get<HomeViewModel>();
    screenModel = viewModel.screenModel;
  }

  final demoList = [
    ChatTileModel(
        emoji: "👋",
        username: "shadowbox",
        message: "😳😋",
        isAuthorSelf: true,
        unreadNumber: 0,
    ),
    ChatTileModel(
      emoji: "🌿",
      username: "planthead",
      message: "❤️🔕🔔",
      isAuthorSelf: false,
      unreadNumber: 2,
    )
  ];

  @override
  Widget build(BuildContext context) {
    final navigateEvent = screenModel.popAndNavigateEvent?.data;
    if (navigateEvent != null) {
      Future.microtask(() => Navigator.pushNamedAndRemoveUntil(
        context, navigateEvent.name, (route) => false,
      ));
    }

    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: demoList.length,
              itemBuilder: (context, index) => buildListTile(context, demoList[index])
          ),
          Align(
            alignment: Alignment.topCenter,
            child: screenModel.loading ? LinearProgressIndicator(
              color: context.getColor(colorAccent),
              backgroundColor: context.getColorWithOpacity(
                  colorPrimary,
                  TextOpacity.medium
              ),
            ) : Container(),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: screenPadding,
      title: Text(
        screenModel.appBarTitle,
        style: Theme.of(context).textTheme.subtitle1?.adaptiveColor(
            context: context, color: colorOnPrimary
        ).copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: false,
      actions: [
        CustomIconButton(
          onPressed: screenModel.loading ? null : () => viewModel.newChatButtonClicked(),
          iconData: Icons.add_rounded,
          tooltip: "New Chat",
        ),
        CustomIconButton(
          onPressed: screenModel.loading ? null : () => viewModel.onLogoutButtonClick(),
          iconData: Icons.logout_rounded,
          tooltip: "Logout",
        ),
      ],
      elevation: 1,
      backgroundColor: context.getColor(colorPrimary),
    );
  }

  Widget buildListTile(BuildContext context, ChatTileModel model) {
    return Container(
      decoration: BoxDecoration(
          color: context.getColor(colorAdaptiveSurface),
          border: Border(
              bottom: BorderSide(
                  color: context.getColorWithOpacity(colorOnAdaptiveSurface, TextOpacity.bare)
              )
          )
      ),
      padding: const EdgeInsets.symmetric(
        vertical: materialSpacingRegular,
        horizontal: screenPadding,
      ),
      child: Row(
        children: [
          Text(
            model.emoji,
            style: Theme.of(context).textTheme.headline4?.adaptiveColor(
                context: context, color: colorOnAdaptiveSurface
            ),
          ),
          const SizedBox(
            width: materialSpacingRegular,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.username,
                  style: Theme.of(context).textTheme.subtitle2?.adaptiveColor(
                      context: context, color: colorOnAdaptiveSurface
                  ),
                ),
                Text(
                  model.subtitle,
                  style: Theme.of(context).textTheme.bodyText1?.adaptiveColor(
                      context: context,
                      color: colorOnAdaptiveSurface
                  ),
                )
              ],
            ),
          ),
          model.unreadNumber > 0
          ? Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.getColor(colorPrimary)
            ),
            child: Center(
              child: Text(
                "${model.unreadNumber <= 99 ? model.unreadNumber : '😬'}",
                style: Theme.of(context).textTheme.bodyText2?.adaptiveColor(
                    context: context, color: colorOnPrimary
                ),
              ),
            ),
          ) : Container()
        ],
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
    getIt.resetLazySingleton<HomeViewModel>();
    super.dispose();
  }

  @override
  void onUpdateNotification() {
    setState(() {
      screenModel = viewModel.screenModel;
    });
  }
}
