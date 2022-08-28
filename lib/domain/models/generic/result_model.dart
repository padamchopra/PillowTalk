import 'package:pillowtalk/domain/models/generic/error_message_model.dart';

class Result<T> {
  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  T? _data;
  T? get data => _data;

  bool get isEmpty => _data == null;

  ErrorMessageModel _error = ErrorMessageModel();
  ErrorMessageModel get error => _error;

  Result._();
  Result.success(T data) {
    _isSuccess = true;
    _data = data;
  }

  Result.empty() {
    _isSuccess = true;
  }

  Result.error({ErrorMessageModel? error, String? msg}) {
    _isSuccess = false;
    if (error != null) {
      _error = error;
    } else if (msg != null) {
      _error = ErrorMessageModel(msg: msg);
    }
  }
}
