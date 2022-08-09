import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillowtalk/data/source/firebase_ds.dart';
import 'package:pillowtalk/data/source/user_service.dart';
import 'package:pillowtalk/domain/models/auth/auth_form_step.dart';
import 'package:pillowtalk/domain/models/auth/auth_landing_state.dart';
import 'package:pillowtalk/domain/models/auth/my_user_model.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';
import 'package:pillowtalk/main.dart';

class UserRepository {
  final FirebaseDS _remoteService;
  late UserService _userService;

  UserRepository(): _remoteService = getIt.get<FirebaseDS>() {
    _userService = _remoteService.userService;
  }

  String? _verificationId;
  MyUser? _user;

  Future<void> submitPhoneNumber(String phoneNumber, Function(Result<AuthFormStep>) callback) async {
    await _remoteService.auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        var authResult = await _submitAuthCredential(credential);
        callback(authResult);
      },
      verificationFailed: (FirebaseAuthException exception) {
        callback(Result.error());
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        callback(Result.success(AuthFormStep.code));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // no-op
      },
    );
  }

  Future<Result<AuthFormStep>> submitOtpCode(String phoneNumber, String code) async {
    var result = Result<AuthFormStep>.error();
    final verificationId = _verificationId;
    if (verificationId != null) {
      return await _submitAuthCredential(
          PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code)
      );
    }
    return result;
  }

  Future<Result<AuthFormStep>> _submitAuthCredential(PhoneAuthCredential credential) async {
    try {
      await _remoteService.auth.signInWithCredential(credential);
      var uid = _remoteService.auth.currentUser?.uid;
      if (uid != null) {
        var result = await _userService.loadUserDetails(uid);
        if (!result.isSuccess) return Result.error(error: result.error);

        // result was success and user found
        if (result.data != null) {
          _user = result.data;
          return Result.success(AuthFormStep.finished);
        }
        // result was success but no user found
        return Result.success(AuthFormStep.username);
      }
      // couldn't complete sign in so show error
      return Result.error();
    } catch (e) {
      return Result.error();
    }
  }

  Future<Result<AuthLandingState>> isUserLoggedIn() async {
    try {
      var uid = _remoteService.auth.currentUser?.uid;
      if (uid == null) return Result.success(AuthLandingState.noUser); // no user
      if (_user != null) return Result.success(AuthLandingState.validUser);
      var result = await _userService.loadUserDetails(uid);
      if (!result.isSuccess) return Result.error(error: result.error);
      if (result.data != null) {
        _user = result.data;
        return Result.success(AuthLandingState.validUser);
      }
      // result was successful but no user found (no username)
      return Result.success(AuthLandingState.noUsername);
    } catch (e) {
      return Result.error();
    }
  }

  Future<Result<AuthFormStep>> setUsername(String username) async {
    var phone = _remoteService.auth.currentUser?.phoneNumber;
    if (phone == null) {
      return Result.error(
        error: ErrorMessageModel(msg: "Could not associate you with an account. Please try signing in again.")
      );
    }
    Map<String, dynamic> details = _user == null ?
    MyUser(
        phone: phone,
        username: username
    ).toMap() :
    {
      MyUserKeys.username.name : username
    };
    var result = await _userService.setUserDetails(details);
    if (result.isSuccess) {
      _user = result.data;
      return Result.success(AuthFormStep.finished);
    }
    return Result.error(error: result.error);
  }
}
