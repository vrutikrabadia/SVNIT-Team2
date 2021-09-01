import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/view.dart';
import 'package:nt_app_front/Services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
          child: Column(
            children: [
              Spacer(),
              Text('Sign Up'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
                controller: email,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
                controller: password,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Confirm Password'),
                controller: confirmPassword,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await Get.find<AuthenticationService>().signUpWithEmail(
                        email.text, password.text, confirmPassword.text);
                    // if (Get.find<AuthenticationService>().idToken.value != '')
                    Get.offAll(() => HomePage());
                  },
                  child: Text('Sign Up')),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
