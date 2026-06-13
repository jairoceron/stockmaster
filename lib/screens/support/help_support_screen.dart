import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmaster/screens/migration_screen.dart';

import 'detail/admin-database.dart';
import '../../services/subscription_demo.dart';
import '../login_screen.dart';
import 'detail/custom_software_screen.dart';
import 'detail/premium_screen.dart';
import 'detail/submit_ticket_screen.dart';
import 'detail/privacy_policy_screen.dart';
import 'detail/about_screen.dart';
import 'detail/faq_screen.dart';
import 'detail/contact_support_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final List<Map<String, dynamic>> _items = [
    {'title': 'FAQs', 'icon': HugeIcons.strokeRoundedHelpCircle},
    {'title': 'Contact Support', 'icon': HugeIcons.strokeRoundedChat},
    {'title': 'Submit a Ticket', 'icon': HugeIcons.strokeRoundedAddInvoice},
    {'title': 'Privacy Policy', 'icon': HugeIcons.strokeRounded1stBrecketCircle},
    {'title': 'About', 'icon': HugeIcons.strokeRoundedInfinity01},
    {'title': 'Admin Database', 'icon': HugeIcons.strokeRoundedDatabase},
    {'title': 'Users Premium', 'icon': HugeIcons.strokeRoundedCrown},
    {'title': 'Custom Software', 'icon': HugeIcons.strokeRounded1Circle},
    {'title': 'Migration', 'icon': HugeIcons.strokeRoundedMouseRightClick01},
  ];

  void _onItemTap(String title) {
    if (title == 'Submit a Ticket') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SubmitTicketScreen()));
    } else if (title == 'Privacy Policy') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()));
    } else if (title == 'About') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AboutScreen()));
    } else if (title == 'FAQs') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FAQScreen()));
    } else if (title == 'Admin Database') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminDatabase()));
    } else if (title == 'Users Premium') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const PremiumScreen()));
    } else if (title == 'Contact Support') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ContactSupportScreen()));
    } else if (title == 'Custom Software') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CustomSoftwareScreen()));
    } else if (title == 'Migration') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MigrationScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tapped: $title')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // fondo claro
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF6A5AE0), // morado primario
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              leading: HugeIcon(
                icon: item['icon'],
                color: const Color(0xFF6A5AE0),
                size: 32,
              ),
              title: Text(
                item['title'],
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () => _onItemTap(item['title']),
            ),
          );
        },
      ),

      // 🔹 FABs apilados con estilo moderno
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            heroTag: "subscriptionFab",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                    appBar: AppBar(title: const Text("Suscripción Demo")),
                    body: const SubscriptionDemo(),
                  ),
                ),
              );
            },
            backgroundColor: const Color(0xFF00A86B), // verde secundario
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedSignal,
              color: Colors.white,
              size: 28.0,
            ),
            label: Text(
              "Suscripción Demo",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: "inventoryLoginFab",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            backgroundColor: const Color(0xFF0073BB), // azul elegante
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUser,
              color: Colors.white,
              size: 28.0,
            ),
            label: Text(
              "Login",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
