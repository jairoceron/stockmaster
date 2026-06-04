import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

import '../services/auth_service.dart';
import 'confirm_screen.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({Key? key}) : super(key: key);

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;

  final Map<String, int> roleMap = {
    'Admin': 1,
    'Viewer': 2,
    'Editor': 3,
  };

  final List<String> roles = ['Admin', 'Viewer', 'Editor'];
  final _authService = AuthService();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          idRol: roleMap[_selectedRole],
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("add_user_success".tr())),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConfirmScreen(email: _emailController.text.trim()),
          ),
        );
      } on AuthException catch (e) {
        if (e.runtimeType.toString() == 'UsernameExistsException' ||
            (e.message != null && e.message!.contains('User already exists'))) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("add_user_exists".tr())),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConfirmScreen(email: _emailController.text.trim()),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("add_user_error".tr(namedArgs: {"error": e.message ?? ""}))),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("add_user_unexpected_error".tr(namedArgs: {"error": e.toString()}))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    final bodyStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colors.black87,
      height: 1.4,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("add_user_title".tr(), style: titleStyle),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("add_user_info_title".tr(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  content: Text("add_user_info_content".tr(), style: bodyStyle),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("close".tr(), style: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("add_user_explanation".tr(), style: bodyStyle, textAlign: TextAlign.justify),
                  ),
                ),
                const SizedBox(height: 24),

                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "add_user_email".tr(),
                            prefixIcon: const Icon(Icons.email),
                            border: const OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "add_user_email_error".tr();
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return "add_user_email_invalid".tr();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: "add_user_password".tr(),
                            prefixIcon: const Icon(Icons.lock),
                            border: const OutlineInputBorder(),
                          ),
                          obscureText: true,
                          validator: (value) =>
                          value == null || value.length < 6 ? "add_user_password_error".tr() : null,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedRole,
                          decoration: InputDecoration(
                            labelText: "add_user_role".tr(),
                            prefixIcon: const Icon(Icons.security),
                            border: const OutlineInputBorder(),
                          ),
                          items: roles.map((role) {
                            return DropdownMenuItem(value: role, child: Text(role));
                          }).toList(),
                          onChanged: (value) => setState(() => _selectedRole = value),
                          validator: (value) => value == null ? "add_user_role_error".tr() : null,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text("add_user_register_button".tr(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _registerUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
