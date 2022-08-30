import 'package:pillowtalk/data/repository/friend_repository.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/usecases/auth/get_user_use_case.dart';
import 'package:pillowtalk/domain/usecases/use_case.dart';
import 'package:pillowtalk/main.dart';

class NewChatRequestUseCase extends UseCase<bool> {
  final FriendRepository _friendRepository;
  final GetUserUseCase _getUserUseCase = GetUserUseCase();
  NewChatRequestUseCase(): _friendRepository = getIt.get<FriendRepository>();

  void sendRequestTo(String username) async {
    if (_getUserUseCase.data.data?.username == username) {
      addError(ErrorMessageModel(msg: "Cannot create chat with yourself"));
    }
    var result = await _friendRepository.sendFriendRequest(username);
    if (result.isSuccess && result.data == true) {
      add(true);
    } else {
      addError(result.error);
    }
  }
}
