import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'sign_in_screen.dart';
import '../screens/home_page.dart';

class AuthGate extends StatefulWidget {
  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      print("auth_gate.dart 00 ${session.isSignedIn}");
      setState(() {
        _isSignedIn = session.isSignedIn;
      });
    } catch (e) {
      print('Error verificando sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn
        ? const MyHomePage(title: '')
        : SignInScreen(onSignedIn: _checkAuth);
  }
}