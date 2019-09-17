import 'package:http/http.dart' as http;

class NetworkCalls {
  static Future getWords() {
    var url = "http://localhost:8080/api/word";
    return http.get(url);
  }

//  static Future logIn({email: String}, {password: String}) {
//    var url = "http://localhost:8080/api/word;"
//  return http.
//  }
}