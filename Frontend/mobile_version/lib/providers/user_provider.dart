import 'package:flutter/widgets.dart';
import 'package:mobile_version/Models/user.dart';
import 'package:sqflite/sqflite.dart';
import '../Database/db_handler.dart';
import 'provider_tools.dart';

class UserProvider with ChangeNotifier {
  var user;

  Future<bool> loginUser(
      {required String username, required String password}) async {
    /*
    This method check the desired user is exist or its credential
    matches or not. If it pass all of this, it will authenticated.
    After authentication, the user will store in the local database
    to preventing login for everytime.
    */
    Map<String, String> userCredential = {
      "username": username,
      "password": password
    };
    Map<String, dynamic> response =
        await sendDataToServer("/users/login", userCredential);

    if (response["status"] == "ok") {
      final userData = {
        "serverId": response["user"]["_id"]["\$oid"],
        "username": response["user"]["username"],
        "email": response["user"]["email"],
      };
      // Insert user into local database
      int localId =
          await DatabaseHandler.insertRecord(table: "users", data: userData);
      userData["localId"] = localId;
      setUser(userData);
      return true;
    }
    return false;
  }

  Future<dynamic> signupUser({
    required String username,
    required String email,
    required String password,
  }) async {
    /*
    This method is for register a new user.
    It receives username, email and passwor, then through
    a post http request sends it to the server. 
    */

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

  Future<bool> logoutUser() async {
    /*
    This method first remove the user from local database, then
    remove the user data from this class.
    */
    DatabaseHandler.deleteRecord("users", user.localId);
    return true;
  }

  bool setUser(userData) {
    user = User(
      localId: userData["localId"],
      serverId: userData["serverId"],
      username: userData["username"],
      email: userData["email"],
    );
    return true;
  }
}
