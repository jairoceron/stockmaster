import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../screens/bottom_navigation_bar.dart';
import '../screens/guest_screen.dart';
import '../services/auth_service.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AppEntryPoint extends StatelessWidget {
  const AppEntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('AppEntryPoint ..... ingresa');
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoggedIn) {
      return const BottomNavBar();
    } else {
      return const GuestScreen();
    }
  }
}
