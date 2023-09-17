import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screen/login_screen.dart';
import 'package:flutter_instagram_clone/screen/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginScreen(go);
    } else {
      return SignupScreen(go);
    }
  }
}
