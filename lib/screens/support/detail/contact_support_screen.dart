import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/screens/support/detail/submit_ticket_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../providers/user_provider.dart';

class ContactSupportScreen extends StatelessWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  Future<void> _launchEmail(BuildContext context) async {
    final appUser = Provider.of<UserProvider>(context, listen: false).user;
    String fromEmail = appUser.email ?? appUser.username ?? "No disponible";

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'vinokurovf@gmail.com',
      query: Uri.encodeFull(
          'subject=App Support&body=User: $fromEmail\n\n'
              'Describe tu problema aquí...\n\n'
              '---\nGracias por contactarnos, te responderemos pronto.'
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("support_open_email".tr())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("support_no_email".tr())),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => SubmitTicketScreen()));
    }
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    final Uri whatsappAppUri = Uri.parse("whatsapp://send?phone=573102952469&text=Hola%20Soporte");
    final Uri whatsappWebUri = Uri.parse("https://wa.me/573102952469?text=Hola%20Soporte");

    if (await canLaunchUrl(whatsappAppUri)) {
      await launchUrl(whatsappAppUri, mode: LaunchMode.externalApplication);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("support_open_whatsapp".tr())),
      );
    } else if (await canLaunchUrl(whatsappWebUri)) {
      await launchUrl(whatsappWebUri, mode: LaunchMode.externalApplication);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("support_open_whatsapp_web".tr())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("support_no_whatsapp".tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: Text("support_title".tr())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => _launchEmail(context),
              icon: const Icon(Icons.email),
              label: Text("support_email".tr()),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _launchWhatsApp(context),
              icon: const Icon(Icons.chat),
              label: Text("support_whatsapp".tr()),
            ),
            const SizedBox(height: 20),
            Text(
              "support_registered_email".tr(namedArgs: {
                "email": appUser.email ?? appUser.username ?? "No disponible"
              }),
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
