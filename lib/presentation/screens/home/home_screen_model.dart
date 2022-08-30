import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/presentation/screens/home/chat_tile_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class HomeScreenModel {
  bool loading = false;
  String appBarTitle = "Hi 👋";
  List<ChatTileModel> chatItems = [];
  Event<Screens>? popAndNavigateEvent;
  Event<Screens>? navigateEvent;

  void setUsername(String? username) {
    if (username != null) {
      appBarTitle = "Hi, @$username 👋";
    }
  }
}
