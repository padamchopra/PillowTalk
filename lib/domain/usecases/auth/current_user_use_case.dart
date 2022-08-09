import 'package:pillowtalk/data/repository/user_repository.dart';
import 'package:pillowtalk/domain/models/auth/auth_landing_state.dart';
import 'package:pillowtalk/domain/usecases/use_case.dart';
import 'package:pillowtalk/main.dart';

class CurrentUserUseCase extends UseCase<AuthLandingState> {
  final UserRepository _userRepository;
  CurrentUserUseCase(): _userRepository = getIt.get<UserRepository>();

  Future<void> isSignedIn() async {
    var result = await _userRepository.isUserLoggedIn();
    if (result.isSuccess) {
      add(result.data ?? AuthLandingState.noUser);
    } else {
      addError(result.error);
    }
  }
}
