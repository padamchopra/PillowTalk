import 'package:pillowtalk/data/repository/user_repository.dart';
import 'package:pillowtalk/domain/models/auth/auth_form_step.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/domain/usecases/use_case.dart';
import 'package:pillowtalk/main.dart';

class AuthFormStepUseCase extends UseCase<AuthFormStep> {
  final UserRepository _userRepository;
  AuthFormStepUseCase(): _userRepository = getIt.get<UserRepository>();

  void submitPhoneNumber(String phoneNumber) async {
    await _userRepository.submitPhoneNumber(phoneNumber, (result) {
      _processResult(result);
    });
  }

  void submitCode(String phoneNumber, String code) async {
    _processResult(await _userRepository.submitOtpCode(phoneNumber, code));
  }

  void submitUsername(String username) async {
    _processResult(await _userRepository.setUsername(username));
  }

  void _processResult(Result<AuthFormStep> result) {
    if (result.isSuccess && !result.isEmpty) {
      add(result.data!);
    } else {
      addError(result.error);
    }
  }
}
