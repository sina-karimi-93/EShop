import 'package:flutter/widgets.dart';

import 'provider_tools.dart';

class UserProvider with ChangeNotifier {
  Future<void> loginUser(String username, String password) async {
    var response = sendDataToServer("/users/login", {});
  }
}
