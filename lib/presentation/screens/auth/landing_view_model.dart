import 'package:pillowtalk/domain/models/auth/auth_form_step.dart';
import 'package:pillowtalk/domain/models/auth/auth_landing_state.dart';
import 'package:pillowtalk/domain/models/generic/event_model.dart';
import 'package:pillowtalk/domain/usecases/auth/current_user_use_case.dart';
import 'package:pillowtalk/presentation/screens/auth/landing_screen_model.dart';
import 'package:pillowtalk/presentation/screens/view_model.dart';
import 'package:pillowtalk/resources/my_router.dart';

class LandingViewModel extends ViewModel {
  final CurrentUserUseCase _useCase = CurrentUserUseCase();

  final LandingScreenModel _screenModel = LandingScreenModel();
  LandingScreenModel get screenModel => _screenModel;

  LandingViewModel() {
    _useCase.isSignedIn();
    _useCase.stream.listen((state) {
      _processStateUpdate(state);
    },
    onError: (error) {
      // TODO: process error by telling user why they have to login again
      _processStateUpdate(AuthLandingState.noUser);
    });
  }

  void _processStateUpdate(AuthLandingState state) {
    switch (state) {
      case AuthLandingState.noUser:
        // No-op
        break;
      case AuthLandingState.noUsername:
        _screenModel.updateFormStepEvent = Event(AuthFormStep.username);
        break;
      case AuthLandingState.validUser:
        _screenModel.navigateScreenEvent = Event(Screens.home);
        break;
    }
    _screenModel.loading = false;
    notify();
  }

  @override
  void dispose() {
    _useCase.close();
  }
}
