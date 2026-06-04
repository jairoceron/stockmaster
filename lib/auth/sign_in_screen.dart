import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../screens/sign_up_screen.dart';
import 'new_password_screen.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import '/auth/recover_password_screen.dart';
import '/services/user_services.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final VoidCallback onSignedIn;

  SignInScreen({super.key, required this.onSignedIn});



  Future<void> _signIn(BuildContext context) async {
    // Capture messenger and navigator early (safe even if widget is disposed later)
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    try {
      final result = await Amplify.Auth.signIn(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (result.isSignedIn) {
        print('✅ Usuario autenticado correctamente');

    //    final appUser = await UserService.fetchCurrentUser();
    //    Provider.of<UserProvider>(context, listen: false).setUser(appUser);

        onSignedIn(); // safe now
      } else {
        if (result.nextStep?.signInStep ==
            AuthSignInStep.confirmSignInWithNewPassword) {
          navigator.push(
            MaterialPageRoute(
              builder: (_) =>
                  NewPasswordScreen(username: emailController.text.trim()),
            ),
          );
        }
      }
    } catch (e) {
      print('Error en login: $e');
      messenger.showSnackBar(
        SnackBar(content: Text('Error en login: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () => _signIn(context),
            child: const Text('Iniciar sesión'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignUpScreen()),
              );
            },
            child: const Text('Registrarse'),
          ),
        ],
      ),
    );
  }
}