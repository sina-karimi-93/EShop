import 'package:flutter/widgets.dart';

import 'provider_tools.dart';

class UserProvider with ChangeNotifier {
  Future<void> loginUser(
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
    print(response);
  }
}
