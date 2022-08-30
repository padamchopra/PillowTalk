import 'package:pillowtalk/domain/models/generic/event_model.dart';

class NewChatScreenModel {
  bool loading = false;
  String? usernameSearchErrorMessage;
  Event<bool>? clearUsernameFieldEvent;
}
