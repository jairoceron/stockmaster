import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../services/auth_service.dart';

class ConfirmScreen extends StatefulWidget {
  final String email;

  const ConfirmScreen({super.key, required this.email});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController codeController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _confirmSignUp() async {
    setState(() => _isLoading = true);
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: widget.email.trim(),
        confirmationCode: codeController.text.trim(),
      );
      if (result.isSignUpComplete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Usuario confirmado correctamente")),
        );
        Navigator.pop(context); // vuelve al login o pantalla anterior
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error confirmando usuario: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resendCode() async {
    setState(() => _isLoading = true);
    try {
      await _authService.resendConfirmationCode(widget.email.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("📧 Código reenviado. Revisa tu correo.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error al reenviar código: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmar Registro"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_open, size: 60, color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  const Text(
                    "Introduce el código enviado a tu correo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: codeController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: "Código de confirmación",
                      prefixIcon: const Icon(Icons.vpn_key),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isLoading ? null : _confirmSignUp,
                      icon: const Icon(Icons.check_circle),
                      label: const Text("Confirmar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _isLoading ? null : _resendCode,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Reenviar código"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
