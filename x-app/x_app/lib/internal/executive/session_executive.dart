import 'dart:convert';

import 'package:x_app/internal/model/DTO/user_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static String aDBVideo = "A8Tyr";
  static List<String> roles = [
    "main",
    "profil_detay",
    "diet_programs",
    "page1"
  ];
  static UserDTO userInMermory;

  static Future<bool> isADBVideo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Session.aDBVideo == prefs.getString("adb_video");
  }

  static Future<bool> removeUser() async {
    try {
      userInMermory = null;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("user_session");
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<bool> setUser(UserDTO user, String userPassword) async {
    try {
      user.password = userPassword;
      userInMermory = user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("user_session", jsonEncode(user.toJson()));
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<UserDTO> getUser() async {
    return userInMermory;
  }

  static Future<UserDTO> getStoryUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = prefs.getString("user_session");
    UserDTO user;
    if (userJson != null && userJson != "") {
      user = UserDTO.fromJson(jsonDecode(userJson));
    } else {
      return null;
    }
    return user;
  }
}
