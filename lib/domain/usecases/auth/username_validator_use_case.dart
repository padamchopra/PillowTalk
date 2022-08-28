import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/domain/usecases/validator_use_case.dart';

class UsernameValidatorUseCase extends ValidatorUseCase<String> {
  @override
  Result<bool> isValid(String data) {
    String? error;
    if (data.contains(" ")) {
      error = "Username cannot contain spaces.";
    } else if (data.contains("@")) {
      error = "Username cannot contain @.";
    } else if (data.length <=3 && data.length > 12) {
      error = "Username can only be 3-12 characters long.";
    }
    return error == null ? Result.success(true) : Result.error(
      error: ErrorMessageModel(msg: error)
    );
  }
}
