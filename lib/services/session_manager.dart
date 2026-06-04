import 'package:amplify_flutter/amplify_flutter.dart';
import '../services/user_services.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SessionManager {
  static Future<bool> checkSession(BuildContext context) async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      if (session.isSignedIn) {
       // final appUser = await UserService.fetchCurrentUser();
       // Provider.of<UserProvider>(context, listen: false).setUser(appUser);
      }
      return session.isSignedIn;
    } catch (e) {
      safePrint("Error verifying session: $e");
      return false;
    }
  }
}
