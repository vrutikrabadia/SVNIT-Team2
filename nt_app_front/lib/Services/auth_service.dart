import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nt_app_front/API/login_register.dart';
import 'dart:convert';

class AuthenticationService extends GetxService {
  var idToken = ''.obs;
//   // ** Sign Up - Registration Methods

  Future<String?> signUpWithEmail(
      String email, String password, String conf) async {
    try {
      print('creating');

      // ** API
      http.Response response = await LoginRegisterApi.onBoardUser(
          email: email, password: password, conf: conf);
      if (response.statusCode == 200) {
        print('created');
        idToken.update((val) {
          idToken.value = json.decode(response.body)['accessToken'];
        });
        return json.decode(response.body)['accessToken'];
      } else {
        print('Some error');
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }

//   // ** Login Methods

  Future<String?> logInWithEmail(String mail, String pass) async {
    print('Signing In with email...');
    try {
      http.Response response =
          await LoginRegisterApi.login(email: mail, password: pass);
      if (response.statusCode == 200) {
        idToken.update((val) {
          idToken.value = json.decode(response.body)['accessToken'];
        });
        print(json.decode(response.body)['accessToken']);
        return json.decode(response.body)['accessToken'];
      } else {
        print('Some error');
      }
    } catch (e) {
      return e.toString();
    }
  }
}
