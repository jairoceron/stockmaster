import 'package:flutter/material.dart';
import '../validators/validators.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '/services/bar_inventario.dart'; // ✅ Importamos la barra

class CompanyDataForm extends StatefulWidget {
  @override
  _CompanyDataFormState createState() => _CompanyDataFormState();
}

class _CompanyDataFormState extends State<CompanyDataForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _paisController = TextEditingController();
  final _ciudadController = TextEditingController();

  bool _isValid = false;

  void _validateForm() {
    setState(() {
      _isValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _saveCompany() async {
    final companyJson = {
      "name": _nameController.text.trim(),
      "email": _emailController.text.trim(),
      "direccion": _addressController.text.trim(),
      "pais": _paisController.text.trim(),
      "ciudad": _ciudadController.text.trim(),
      "celular": _phoneController.text.trim(),
    };

    final url = Uri.parse(
        "https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/queryMiel06");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(companyJson),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data saved successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarInventario.buildAppBar(context, "Company"), // ✅ Usamos la barra personalizada
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: _validateForm,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: Validators.validateName,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: "+573001234567",
                ),
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                validator: Validators.validateAddress,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _paisController,
                decoration: const InputDecoration(
                  labelText: "Country",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                validator: Validators.validatePais,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _ciudadController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: Validators.validateCiudad,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isValid
                    ? () {
                  if (_formKey.currentState!.validate()) {
                    _saveCompany();
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}