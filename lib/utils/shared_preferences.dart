import 'package:shared_preferences/shared_preferences.dart';
import '../constants/shared_prefs_keys.dart';

class SharedPref {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  // Set a String value
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }
  // Get a String value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }
  // Set a Boolean value
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }
  // Get a Boolean value
  static bool? getbool(String key){
    return _prefs?.getBool(key);
  }
  // Set a isfirstlaunch
  static Future<void> setIsFirstLaunch(bool value) async{
    await _prefs?.setBool(AppKeys.isFirstTime, value);
  }
  // get a isfirstlaunch
  static bool? isFirstLaunch(){
    return _prefs?.getBool(AppKeys.isFirstTime)?? true;
  }
  // set last opened time
  static Future<void> setlastopened(DateTime time) async{
    await _prefs?.setString(AppKeys.lastopened, time.toIso8601String());
  }
  // get last opened time
  static DateTime? getLastopened(){
    final timeString = _prefs?.getString(AppKeys.lastopened);
    if(timeString == null) return null;
    return DateTime.tryParse(timeString);
  }

  }
