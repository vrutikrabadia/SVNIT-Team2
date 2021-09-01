import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Presentation/Screens/LoginPage/view.dart';
import 'Services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthenticationService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: HomePage(),
      home: LoginPage(),
    );
  }
}
