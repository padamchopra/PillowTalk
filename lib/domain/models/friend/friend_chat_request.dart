import 'package:cloud_firestore/cloud_firestore.dart';

enum FriendChatRequestKeys{from, to, createdAt}
class FriendChatRequest {
  late String _from;
  late String _to;
  late DateTime? _createdAt;
  FriendChatRequest(String from, String to) {
    _from = from;
    _to = to;
    _createdAt = DateTime.tryParse(FieldValue.serverTimestamp().toString());
  }

  FriendChatRequest.fromMap(Map<String, dynamic> data) {
    _from = data[FriendChatRequestKeys.from.name];
    _to = data[FriendChatRequestKeys.to.name];
    _createdAt = DateTime.tryParse(data[FriendChatRequestKeys.createdAt.name]);
  }
}

extension FriendChatRequestProperties on FriendChatRequest {
  Map<String, dynamic> toMap() {
    return {
      FriendChatRequestKeys.from.name : _from,
      FriendChatRequestKeys.to.name : _to,
      FriendChatRequestKeys.createdAt.name : _createdAt ?? ""
    };
  }
}
