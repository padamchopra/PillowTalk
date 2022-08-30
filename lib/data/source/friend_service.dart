import 'package:pillowtalk/domain/models/generic/result_model.dart';

mixin FriendService {
  Future<Result<bool>> sendNewRequest(String username);
}
