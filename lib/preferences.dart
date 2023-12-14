import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static String email = '';
  static String name = '';
  static String sex = '';

  // Write data to shared preferences
  static Future<bool> saveUserData(String userEmail, String userName, String userSex) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('email', userEmail);
    await sharedPreferences.setString('name', userName);
    await sharedPreferences.setString('sex', userSex);
    return true;
  }

  // Read data from shared preferences
  static Future<Map<String, String>> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEmail = sharedPreferences.getString('email');
    String? userName = sharedPreferences.getString('name');
    String? userSex = sharedPreferences.getString('sex');
    return {'email': userEmail ?? '', 'name': userName ?? '', 'sex': userSex ?? ''};
  }
}
