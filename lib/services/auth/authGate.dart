import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hey_app/pages/HomePage.dart';
import 'package:hey_app/pages/LoginPage.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
           if (snapshot.hasData) {
            // User is authenticated
            return HomePage(); // Ensure HomePage() is correct and does not need context
          } else {
            // User is not authenticated
            return LoginPage(); // Ensure LoginPage() is correct and does not need context
          }
        },
      ),
    );
  }
}
