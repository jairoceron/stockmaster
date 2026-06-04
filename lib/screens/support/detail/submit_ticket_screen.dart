import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

import '../../../providers/user_provider.dart';

class SubmitTicketScreen extends StatefulWidget {
  const SubmitTicketScreen({Key? key}) : super(key: key);

  @override
  State<SubmitTicketScreen> createState() => _SubmitTicketScreenState();
}

class _SubmitTicketScreenState extends State<SubmitTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _whatsappController = TextEditingController();
  final _clientNameController = TextEditingController();
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _whatsappController.dispose();
    _clientNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitTicket() async {
    if (_formKey.currentState!.validate()) {
      final mutation = ''' ... '''; // tu mutación GraphQL

      final variables = {
        "idbusiness": context.read<UserProvider>().user.username,
        "client_name": _clientNameController.text.trim(),
        "whatsapp": _whatsappController.text.trim(),
        "email": _emailController.text.trim(),
        "subject": _subjectController.text.trim(),
        "description": _descriptionController.text.trim(),
        "country": _countryController.text.trim(),
        "city": _cityController.text.trim(),
      };

      try {
        final session = await Amplify.Auth.fetchAuthSession();

        if (session.isSignedIn) {
          final req = GraphQLRequest<String>(
            document: mutation,
            variables: variables,
          );
          final res = await Amplify.API.mutate(request: req).response;

          if (res.errors.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("support_ticket_error".tr(namedArgs: {"error": res.errors.first.message}))),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("support_ticket_sent_cognito".tr())),
            );
          }
        } else {
          final lambdaEndpoint = Uri.parse("https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/stockMasterRegisterContactSupport");

          final response = await http.post(
            lambdaEndpoint,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(variables),
          );

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("support_ticket_sent_lambda".tr())),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("support_ticket_error_lambda".tr(namedArgs: {"error": response.body}))),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("support_ticket_error".tr(namedArgs: {"error": e.toString()}))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<UserProvider>(context).user;
    final username = appUser.username?.isNotEmpty == true ? appUser.username! : "Invitado";

    if (appUser.email != null && appUser.email!.isNotEmpty) {
      _emailController.text = appUser.email!;
    }
    if (appUser.username != null && appUser.username!.isNotEmpty) {
      _clientNameController.text = appUser.username!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("support_title".tr()),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    child: Text(username[0].toUpperCase()),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("support_current_user".tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(username, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),

              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text("support_contact_data".tr(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _clientNameController,
                        decoration: InputDecoration(labelText: "support_name".tr(), icon: const Icon(Icons.person)),
                        validator: (value) => value == null || value.isEmpty ? "support_error_name".tr() : null,
                      ),
                      TextFormField(
                        controller: _whatsappController,
                        decoration: InputDecoration(labelText: "support_whatsapp".tr(), icon: const Icon(Icons.phone)),
                        validator: (value) => value == null || value.isEmpty ? "support_error_whatsapp".tr() : null,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: "support_email".tr(), icon: const Icon(Icons.email)),
                        validator: (value) {
                          if (value == null || value.isEmpty) return "support_error_email".tr();
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) return "support_error_invalid_email".tr();
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text("support_ticket_details".tr(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextFormField(
                        controller: _subjectController,
                        decoration: InputDecoration(labelText: "support_subject".tr(), icon: const Icon(Icons.title)),
                        validator: (value) => value == null || value.isEmpty ? "support_error_subject".tr() : null,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(labelText: "support_description".tr(), icon: const Icon(Icons.description)),
                        maxLines: 4,
                        validator: (value) => value == null || value.isEmpty ? "support_error_description".tr() : null,
                      ),
                      TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(labelText: "support_country".tr(), icon: const Icon(Icons.flag)),
                      ),
                      TextFormField(
                        controller: _cityController,
                        decoration: InputDecoration(labelText: "support_city".tr(), icon: const Icon(Icons.location_city)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitTicket,
                icon: const Icon(Icons.send),
                label: Text("support_send_request".tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
