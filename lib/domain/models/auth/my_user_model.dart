enum MyUserKeys {phone, username, username_unique}
class MyUser {
  late String _phone;
  late String _username;

  MyUser({
    required String phone,
    required String username,
  }): _phone = phone,
  _username = username;

  MyUser.fromMap(Map<String, dynamic> data) {
    _phone = data[MyUserKeys.phone.name];
    _username = data[MyUserKeys.username.name];
  }
}

extension MyUserProperties on MyUser {
  Map<String, dynamic> toMap() {
    return {
      MyUserKeys.phone.name : _phone,
      MyUserKeys.username.name : _username
    };
  }
}
