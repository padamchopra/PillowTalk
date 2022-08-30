import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/domain/usecases/auth/get_user_use_case.dart';
import 'package:pillowtalk/domain/usecases/auth/sign_out_use_case.dart';
import 'package:pillowtalk/presentation/screens/home/home_screen_model.dart';
import 'package:pillowtalk/presentation/screens/view_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class HomeViewModel extends ViewModel {
  final GetUserUseCase _getUserUseCase = GetUserUseCase();
  final SignOutUseCase _signOutUseCase = SignOutUseCase();

  late HomeScreenModel _screenModel;
  HomeScreenModel get screenModel => _screenModel;

  HomeViewModel() {
    _screenModel = HomeScreenModel();
    _screenModel.loading = false;
    _getUsername();

    _signOutUseCase.stream.listen((success) {
      _processSignOutResponse(true);
    }, onError: (error) {
      // TODO: process error by telling user something better
      _processSignOutResponse(false);
    });
  }

  void _getUsername() {
    var user = _getUserUseCase.data;
    if (user.isSuccess) {
      _screenModel.setUsername(user.data?.username);
    } else {
      // TODO: process error by telling user something better
      _screenModel.popAndNavigateEvent = Event(Screens.landing);
      _screenModel.loading = false;
    }
  }


  // Region: user actions
  void onLogoutButtonClick() {
    _screenModel.loading = true;
    notify();
    _signOutUseCase.signOut();
  }

  void newChatButtonClicked() {
    _screenModel.navigateEvent = Event(Screens.newChat);
    notify();
  }

  // region ends

  void _processSignOutResponse(bool success) {
    if (success) {
      _screenModel.popAndNavigateEvent = Event(Screens.landing);
    }
    _screenModel.loading = false;
    notify();
  }

  @override
  void dispose() {
    _signOutUseCase.close();
  }
}
