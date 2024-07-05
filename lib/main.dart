import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hey_app/firebase_options.dart';
import 'package:hey_app/pages/HomePage.dart';
import 'package:hey_app/pages/SignupPage.dart';
import 'package:hey_app/themes/lightMode.dart';
import 'package:hey_app/services/auth/LoginOrRegister.dart';

import 'services/auth/authGate.dart';
import 'pages/LoginPage.dart';

 void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: lightMode,
    );
  }
}
