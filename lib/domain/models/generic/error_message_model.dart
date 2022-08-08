class ErrorMessageModel {
  late String _message;
  String get message => _message;
  ErrorMessageModel({String? msg}) {
    _message = msg ?? "An error occurred. Please try again or contact support.";
  }
}
