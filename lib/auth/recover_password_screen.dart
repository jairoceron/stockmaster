import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  bool _codeSent = false;

  Future<void> _sendCode() async {
    try {
      final email = _emailController.text.trim();
      await Amplify.Auth.resetPassword(username: email);
      setState(() {
        _codeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Código enviado al correo $email")),
      );
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  Future<void> _confirmNewPassword() async {
    try {
      final email = _emailController.text.trim();
      final code = _codeController.text.trim();
      final newPassword = _newPasswordController.text.trim();

      await Amplify.Auth.confirmResetPassword(
        username: email,
        newPassword: newPassword,
        confirmationCode: code,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contraseña restablecida con éxito")),
      );

      Navigator.pop(context); // Regresa al login
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Contraseña"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (!_codeSent)
              ElevatedButton(
                onPressed: _sendCode,
                child: const Text("Enviar código"),
              ),
            if (_codeSent) ...[
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: "Código de verificación",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Nueva contraseña",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmNewPassword,
                child: const Text("Confirmar nueva contraseña"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}