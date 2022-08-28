import 'package:pillowtalk/data/repository/user_repository.dart';
import 'package:pillowtalk/domain/models/auth/my_user_model.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/domain/usecases/getter_use_case.dart';
import 'package:pillowtalk/main.dart';

class GetUserUseCase extends GetterUserCase<MyUser> {
  final UserRepository _userRepository;
  GetUserUseCase(): _userRepository = getIt.get<UserRepository>();

  @override
  Result<MyUser> get data {
    MyUser? user = _userRepository.user;
    if (user == null) {
      return Result.error(
        error: ErrorMessageModel(msg: "User was signed out. Please sign in again.")
      );
    }
    return Result.success(user);
  }
}
