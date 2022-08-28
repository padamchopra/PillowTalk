class ChatTileModel {
  final String _emoji;
  String get emoji => _emoji;

  final String _username;
  String get username => _username;

  final String _message;
  final bool _isAuthorSelf;
  String get subtitle {
    return "${_isAuthorSelf ? "You: " : ""}$_message";
  }

  final int _unreadNumber;
  int get unreadNumber => _unreadNumber;

  ChatTileModel({
    required String emoji,
    required String username,
    required String message,
    required bool isAuthorSelf,
    required int unreadNumber
  }): _emoji = emoji,
  _username = username,
  _message = message,
  _isAuthorSelf = isAuthorSelf,
  _unreadNumber = unreadNumber;
}

