import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/company_service.dart';
import '../validators/validators.dart';
import 'confirm_screen.dart';
import 'excepcion_personalizada.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart'; // 👈 importa el paquete uuid

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userPasswordController = TextEditingController();
  bool _obscurePassword = true; // estado inicial
  final _formKey = GlobalKey<FormState>();

  // Empresa
  final companyNameController = TextEditingController();
  final companyAddressController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyPaisController = TextEditingController();
  final companyCiudadController = TextEditingController();
  final companyEmailController = TextEditingController();

  // Usuario
  final userNameController = TextEditingController();
  final userEmailController = TextEditingController();
  // final userPasswordController = TextEditingController();

  bool _isValid = false;
  int? _businessId;

  final _authService = AuthService();
  final _companyService = CompanyService();

  void _validateForm() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _saveAndRegister() async {
    if (_formKey.currentState!.validate()) {
      try {
        final url = Uri.parse(
          "https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/registerCompanyUser",
        );
// 👇 Generar UUID único para idbusiness
        final uuid = const Uuid().v4();
        final body = {
          "company": {
            "idbusiness": uuid, // 👈 agregado
            "name": companyNameController.text.trim(),
            "email": companyEmailController.text.trim(),
            "direccion": companyAddressController.text.trim(),
            "pais": companyPaisController.text.trim(),
            "ciudad": companyCiudadController.text.trim(),
            "celular": companyPhoneController.text.trim(),
          },
          "user": {
            "idbusiness": uuid, // 👈 agregado
            "name": userNameController.text.trim(),
            "email": userEmailController.text.trim(),
            "password": userPasswordController.text.trim(),
          },
        };

        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Usuario registrado. Revisa tu correo."),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ConfirmScreen(email: userEmailController.text.trim()),
            ),
          );
        } else {
          throw Exception("Error en registro: ${response.body}");
        }
      } catch (e) {
        ExcepcionPersonalizada(
          mensaje: "Error en registro: $e",
        ).mostrar(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: _validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sección Empresa
              Card(
                color: theme.colorScheme.primary.withOpacity(0.05),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Datos de la Empresa",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: companyNameController,
                        decoration: const InputDecoration(
                          labelText: "Nombre de la empresa",
                        ),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: companyAddressController,
                        decoration: const InputDecoration(
                          labelText: "Dirección",
                        ),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: companyPhoneController,
                        decoration: const InputDecoration(
                          labelText: "Teléfono",
                        ),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: companyCiudadController,
                        decoration: const InputDecoration(labelText: "Ciudad"),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: companyPaisController,
                        decoration: const InputDecoration(labelText: "País"),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: companyEmailController,
                        decoration: const InputDecoration(
                          labelText: "Correo empresa",
                        ),
                        validator: Validators.validateEmail,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sección Usuario
              Card(
                color: theme.colorScheme.secondary.withOpacity(0.05),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Datos del Usuario",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          labelText: "Nombre completo",
                        ),
                        validator: Validators.notEmptyValidator,
                      ),
                      TextFormField(
                        controller: userEmailController,
                        decoration: const InputDecoration(
                          labelText: "Correo electrónico",
                        ),
                        validator: Validators.validateEmail,
                      ),
                      TextFormField(
                        controller: userPasswordController,
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        validator: Validators.passwordValidator,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _isValid ? _saveAndRegister : null,
                icon: const Icon(Icons.check),
                label: const Text("Registrarse -"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
