import 'package:http/http.dart' as http;
import 'package:nt_app_front/API/config.dart';

class LoginRegisterApi {
  static Future<http.Response> onBoardUser(
      {required String email,
      required String password,
      required String conf}) async {
    final String url = AppConfig.baseUrl + "/signup";
    var client = http.Client();
    try {
      var uriResponse = await client.post(
        Uri.parse(url),
        headers: {},
        body: {
          "username": email,
          "password": password,
          "confirm": conf,
        },
      );

      return uriResponse;
    } finally {
      client.close();
    }
  }

  static Future<http.Response> login(
      {required String email, required String password}) async {
    final String url = AppConfig.baseUrl + "/login";
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse(url), body: {
        "username": email,
        "password": password,
      });
      return uriResponse;
    } finally {
      client.close();
    }
  }
}
