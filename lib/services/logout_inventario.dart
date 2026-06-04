import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '/screens/login_screen.dart';

class LogoutInventario {
  static Future<void> ejecutarLogout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cerrar sesión"),
        content: const Text("¿Estás seguro de que deseas salir de la aplicación?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Salir"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        // Cierra sesión en Cognito
        await Amplify.Auth.signOut();

        // Redirige al LoginScreen con mensaje de logout
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(showLogoutMessage: true),
          ),
              (route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cerrar sesión: $e")),
        );
      }
    }
  }
}