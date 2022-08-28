import 'package:pillowtalk/domain/models/generic/result_model.dart';

abstract class ValidatorUseCase<T> {
  Result<bool> isValid(T data);
}
