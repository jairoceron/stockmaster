import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/user_provider.dart';
import 'submit_ticket_screen.dart';

class CustomSoftwareScreen extends StatelessWidget {
  const CustomSoftwareScreen({Key? key}) : super(key: key);

  Future<void> _launchEmail(BuildContext context) async {
    final appUser = Provider.of<UserProvider>(context, listen: false).user;
    String fromEmail = appUser.email ?? appUser.username ?? "No disponible";

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'vinokurovf@gmail.com',
      query: Uri.encodeFull(
        'subject=Custom Software Request&body=User: $fromEmail\n\n'
            'Estoy interesado en una solución personalizada.\n\n'
            '---\nGracias por contactarnos, Datatoool.',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SubmitTicketScreen()));
    }
  }

  Future<void> _launchWhatsApp(BuildContext context) async {
    final Uri whatsappAppUri = Uri.parse("whatsapp://send?phone=573102952469&text=Hola%20Datatoool,%20quiero%20una%20solución%20personalizada");
    final Uri whatsappWebUri = Uri.parse("https://wa.me/573102952469?text=Hola%20Datatoool,%20quiero%20una%20solución%20personalizada");

    if (await canLaunchUrl(whatsappAppUri)) {
      await launchUrl(whatsappAppUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(whatsappWebUri)) {
      await launchUrl(whatsappWebUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appUser = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text("custom_title".tr(), style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF6A5AE0),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("custom_intro".tr(),
                style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF333333))),
            const SizedBox(height: 16),
            Text("custom_body".tr(),
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 32),

            // Beneficios
            _buildBenefitCard(Icons.cloud, "benefit_cloud".tr(), "benefit_cloud_desc".tr()),
            _buildBenefitCard(Icons.people, "benefit_multiuser".tr(), "benefit_multiuser_desc".tr()),
            _buildBenefitCard(Icons.phone_android, "benefit_mobile".tr(), "benefit_mobile_desc".tr()),
            _buildBenefitCard(Icons.auto_graph, "benefit_scalable".tr(), "benefit_scalable_desc".tr()),

            const SizedBox(height: 32),

            // Call to Action
            Center(
              child: Column(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A86B),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _launchWhatsApp(context),
                    icon: const Icon(Icons.chat, color: Colors.white),
                    label: Text("cta_whatsapp".tr(), style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6A5AE0),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _launchEmail(context),
                    icon: const Icon(Icons.email, color: Colors.white),
                    label: Text("cta_email".tr(), style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'Tu correo registrado: ${appUser.email ?? appUser.username ?? "No disponible"}',
              style: GoogleFonts.poppins(fontStyle: FontStyle.italic, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitCard(IconData icon, String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6A5AE0), size: 32),
        title: Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        subtitle: Text(description, style: GoogleFonts.poppins(color: Colors.black87)),
      ),
    );
  }
}
