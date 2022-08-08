import 'package:pillowtalk/domain/models/auth/my_user_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';

mixin UserService {
  Future<Result<MyUser?>> loadUserDetails(String uid);

  Future<Result<MyUser>> setUserDetails(Map<String, dynamic> details);
}
