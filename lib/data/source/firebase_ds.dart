import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillowtalk/data/source/friend_service.dart';
import 'package:pillowtalk/data/source/user_service.dart';
import 'package:pillowtalk/domain/models/auth/my_user_model.dart';
import 'package:pillowtalk/domain/models/friend/friend_chat_request.dart';
import 'package:pillowtalk/domain/models/generic/error_message_model.dart';
import 'package:pillowtalk/domain/models/generic/result_model.dart';

class FirebaseDS with UserService, FriendService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAuth get auth => _auth;

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  FirebaseFirestore get db => _database;

  UserService get userService => this;
  FriendService get friendService => this;

  FirebaseDS() {
    _usersCollection = db.collection(usersCollectionKey);
    _requestsCollection = db.collection(requestsCollectionKey);
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

  // Region: Friend service
  final String requestsCollectionKey = "friendRequests";
  late CollectionReference _requestsCollection;

  @override
  Future<Result<bool>> sendNewRequest(String username) async {
    // check if username even exists
    var qs = await _usersCollection.where(
      MyUserKeys.username_unique.name,
      isEqualTo: username.toLowerCase(),
    ).get();
    if (qs.size < 1) {
      return Result.error(
          error: ErrorMessageModel(
              msg: "Username cannot be found. Please make sure you've entered the correct username and try again.",
          ),
      );
    }

    // check if there is a pending request
    var senderId = _auth.currentUser?.uid;
    var receiverData = qs.docs.first;
    if (senderId == null || !receiverData.exists) {
      return Result.error();
    }
    var requestQs = await _requestsCollection.where(
      FriendChatRequestKeys.from,
      isEqualTo: senderId
    ).where(
      FriendChatRequestKeys.to,
      isEqualTo: receiverData.id
    ).get();
    if (requestQs.size > 0) {
      return Result.error(
        error: ErrorMessageModel(
          msg: "You already have a pending request to this username. Please wait for them to respond.",
        ),
      );
    }

    // attempt to create request
    var request = FriendChatRequest(senderId, receiverData.id);
    try {
      await _requestsCollection.add(request.toMap());
      return Result.success(true);
    } catch (e) {
      return Result.error();
    }
  }
  // region ends
}
