import 'dart:convert';
import 'package:word_app_fl/Models/word.dart';
import 'package:http/http.dart' as http;
import 'package:word_app_fl/Utils/shared_prefs_helpers.dart';

class NetworkCalls {
  static Future getWords() {
    var url = "http://localhost:8080/api/word";
    return http.get(url);
  }

  static Future logIn({email: String, password: String}) {
    var url = "http://localhost:8080/api/users/login";
    String basicAuth = "Basic " + base64Encode(utf8.encode("$email:$password"));
  return http.post(
    url,
    headers: <String, String>{"authorization": basicAuth});
  }

  static Future update({word: Word}) async {
    String token = await SharedPrefsHelper.getToken();
    var json = jsonEncode(word.toJson());
    var url = "http://localhost:8080/api/word/${word.id}";
    return http.patch(
      url,
      body: json,
      headers: <String, String>{"authorization": "Bearer $token", "Content-Type": "application/json"});
  }
}