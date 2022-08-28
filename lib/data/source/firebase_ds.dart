import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillowtalk/data/source/user_service.dart';
import 'package:pillowtalk/domain/models/auth/my_user_model.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';

class FirebaseDS with UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseFirestore get db => _database;

  UserService get userService => this;

  FirebaseDS() {
    _usersCollection = db.collection(usersCollectionKey);
  }


  // Region: User Service
  final String usersCollectionKey = "users";
  late CollectionReference _usersCollection;

  @override
  Future<Result<MyUser>> loadUserDetails(String uid) async {
    try {
      var ds = await _usersCollection.doc(uid).get();
      if (ds.exists) {
        var data = ds.data() as Map<String, dynamic>;
        return Result.success(MyUser.fromMap(data));
      }
      return Result.empty();
    } catch (e) {
      return Result.error();
    }
  }

  @override
  Future<Result<MyUser>> setUserDetails(Map<String, dynamic> details) async {
    try {
      var uid = auth.currentUser?.uid;
      if (uid == null) return Result.error();
      if (details.containsKey(MyUserKeys.username.name)) {
        String username = details[MyUserKeys.username.name];
        var qs = await _usersCollection.where(
            MyUserKeys.username_unique.name,
            isEqualTo: username.toLowerCase(),
        ).get();
        if (qs.size > 0) {
          return Result.error(
            error: ErrorMessageModel(msg: "This username is unavailable.")
          );
        }
      }
      if ((await _usersCollection.doc(uid).get()).exists) {
        await _usersCollection.doc(uid).update(details);
      } else {
        await _usersCollection.doc(uid).set(details);
      }
      var result = await loadUserDetails(uid);
      if (result.isSuccess && !result.isEmpty) {
        return Result.success(result.data!);
      }
      return Result.error();
    } catch (e) {
      return Result.error();
    }
  }

  // region ends
}
