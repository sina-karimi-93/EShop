import 'package:flutter/widgets.dart';
import 'package:mobile_version/Models/user.dart';

import 'provider_tools.dart';

class UserProvider with ChangeNotifier {
  var user;

  Future<bool> loginUser(
      {required String username, required String password}) async {
    /*
    This method check the desired user is exist or its credential
    matches or not. If it pass all of this, it will authenticated.
    */
    Map<String, String> userCredential = {
      "username": username,
      "password": password
    };
    Map<String, dynamic> response =
        await sendDataToServer("/users/login", userCredential);
    if (response["status"] == "ok") {
      Map<String, dynamic> userData = response["user"];
      user = User(
        id: userData["_id"]["\$oid"],
        username: userData["username"],
        email: userData["email"],
      );
      return true;
    }
    return false;
  }

  Future<dynamic> signupUser({
    required String username,
    required String email,
    required String password,
  }) async {
    Map<String, String> userCredential = {
      "username": username,
      "email": email,
      "password": password,
    };
    Map<String, dynamic> response =
        await sendDataToServer('/users/signup', userCredential);
    if (response["status"] == "ok") {
      return true;
    }
    return response["message"];
  }
}
