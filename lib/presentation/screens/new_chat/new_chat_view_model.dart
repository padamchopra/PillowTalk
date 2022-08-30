import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/domain/usecases/friends/new_chat_request_use_case.dart';
import 'package:pillowtalk/presentation/screens/new_chat/new_chat_screen_model.dart';
import 'package:pillowtalk/presentation/screens/view_model.dart';

class NewChatViewModel extends ViewModel {
  final NewChatRequestUseCase _newChatRequestUseCase = NewChatRequestUseCase();
  final NewChatScreenModel _screenModel = NewChatScreenModel();
  NewChatScreenModel get screenModel => _screenModel;

  NewChatViewModel() {
    _newChatRequestUseCase.stream.listen((event) {
      processRequestResponse(Result.success(event));
    }, onError: (error) {
      processRequestResponse(Result.error(error: error));
    });
  }

  String _usernameInSearchField = "";

  // Region: user actions
  void usernameSearchTextChange(String text) {
    _usernameInSearchField = text;
  }

  void sendNewChatRequest() {
    _screenModel.usernameSearchErrorMessage = "";
    _screenModel.loading = true;
    notify();
    _newChatRequestUseCase.sendRequestTo(_usernameInSearchField);
  }
  // region ends

  void processRequestResponse(Result<bool> response) {
    _screenModel.loading = false;
    if (response.isSuccess && response.data == true) {
      _screenModel.clearUsernameFieldEvent = Event(true);
    } else {
      _screenModel.usernameSearchErrorMessage = response.error.message;
    }
    notify();
  }

  @override
  void dispose() {
    _newChatRequestUseCase.close();
  }
}
