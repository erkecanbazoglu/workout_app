import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _preferences;

  static const _userWorkouts = 'userWorkouts';

  //Init SharedPreferences
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //Functions go here
  //Later not used, instead used Hydrated Bloc
}
