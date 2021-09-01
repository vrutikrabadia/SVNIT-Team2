import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_front/Presentation/Screens/Hompage/view.dart';
import 'package:nt_app_front/Presentation/Screens/SignUpPage/view.dart';
import 'package:nt_app_front/Services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(250, 0, 250, 0),
          child: Column(
            children: [
              Spacer(),
              Text('Login'),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Email'),
                controller: emailController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Password'),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () async {
                    await Get.find<AuthenticationService>().logInWithEmail(
                        emailController.text, passwordController.text);
                    Get.offAll(() => HomePage());
                  },
                  child: Text('Login')),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => SignUpPage());
                  },
                  child: Text('SignUp Instead')),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
