import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '/screens/home_page.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '/services/user_services.dart';

class NewPasswordScreen extends StatelessWidget {
  final String username;
  final TextEditingController newPasswordController = TextEditingController();

  NewPasswordScreen({required this.username});



  Future<void> _confirmNewPassword(BuildContext context) async {
    try {
      final result = await Amplify.Auth.confirmSignIn(
        confirmationValue: newPasswordController.text.trim(),
      );

      if (result.isSignedIn) {
      //  final appUser = await UserService.fetchCurrentUser();
      //  Provider.of<UserProvider>(context, listen: false).setUser(appUser);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Inicio')));
      } else {
        print('⚠️ Confirmación incompleta: ${result.nextStep}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: newPasswordController, decoration: const InputDecoration(labelText: 'Nueva contraseña'), obscureText: true),
          ElevatedButton(onPressed: () => _confirmNewPassword(context), child: const Text('Confirmar nueva contraseña')),
        ],
      ),
    );
  }
}