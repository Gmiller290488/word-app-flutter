import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_format/date_format.dart';
import 'database_helpers.dart';

class SharedPrefsHelper {

  static updateDateLastOpened() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'timeStamp';
    final value = formatDate(DateTime.now(), [dd, '.', mm, '.', yy]);
    prefs.setString(key, value);
  }

  static Future<String> readDateLastOpened() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'timeStamp';
    return prefs.getString(key);
  }

  static Future<bool> appWasOpenedToday() async {
     String dateLastOpened = await readDateLastOpened();
     String dateNow = formatDate(DateTime.now(), [dd, '.', mm, '.', yy]);
     return dateNow == dateLastOpened;
  }

  static updateTodaysRegisteredWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'todaysWord';
    final value = id;
    prefs.setInt(key, value);
  }

  static Future<int> getTodaysRegisteredWord() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'todaysWord';
    return prefs.getInt(key) ?? 1;
  }

  static updateTodaysGuestWord(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'todaysWord';
    final value = id;
    prefs.setInt(key, value);
  }

  static Future<int> getTodaysGuestWord() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'todaysWord';
    return prefs.getInt(key) ?? 1;
  }

  static updateToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    print(value);
    prefs.setString(key, value);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    return prefs.getString(key);
  }

  static updateId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = id;
    print(value);
    prefs.setInt(key, value);
  }

  static Future<int> getId() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    return prefs.getInt(key);
  }
}