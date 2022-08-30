import 'package:pillowtalk/data/source/firebase_ds.dart';
import 'package:pillowtalk/data/source/friend_service.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/main.dart';

class FriendRepository {
  final FirebaseDS _remoteService;
  late FriendService _friendService;
  FriendRepository(): _remoteService = getIt.get<FirebaseDS>() {
    _friendService = _remoteService.friendService;
  }

  Future<Result<bool>> sendFriendRequest(String username) async {
    return await _friendService.sendNewRequest(username);
  }
}
