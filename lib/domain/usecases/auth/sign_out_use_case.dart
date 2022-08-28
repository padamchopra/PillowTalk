import 'package:pillowtalk/data/repository/user_repository.dart';
import 'package:pillowtalk/domain/usecases/use_case.dart';
import 'package:pillowtalk/main.dart';

class SignOutUseCase extends UseCase<bool> {
  final UserRepository _userRepository;
  SignOutUseCase(): _userRepository = getIt.get<UserRepository>();

  void signOut() async {
    var result = await _userRepository.signOutUser();
    if (result.data == true) {
      add(true);
    } else {
      addError(result.error);
    }
  }
}
