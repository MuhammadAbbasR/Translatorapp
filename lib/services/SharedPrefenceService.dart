import 'package:camera_ocr_scanner/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefencesService {
  static SharedPreferences? _prefs;

  static Future initialize_SharedPrefence() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> boolsetSignup(UserModel user) async {
    bool successName = await _prefs!.setString("username", user.username);
    bool successEmail = await _prefs!.setString("email", user.email);
    bool successPassword = await _prefs!.setString("password", user.password);

    if (successPassword && successEmail && successName) {
      return true;
    } else {
      return false;
    }
  }

  static bool setlogin(UserModel user) {
    String? email = _prefs!.getString("email");
    String? password = _prefs!.getString("password");

    if (email == user.email && password == user.email) {
      return true;
    } else {
      return false;
    }
  }

  static String getname() {
    String? name = _prefs!.getString("username");

    return name!;
  }
}
