import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.indigo,
    );

    final sectionTitleStyle = GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );

    final bodyStyle = GoogleFonts.montserrat(
      fontSize: 16,
      height: 1.5,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("privacy_title".tr(), style: titleStyle),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.indigo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildCard("privacy_title".tr(), "privacy_intro".tr(), sectionTitleStyle, bodyStyle),
            const SizedBox(height: 20),
            _buildCard("terms_title".tr(), "terms_content".tr(), sectionTitleStyle, bodyStyle),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  Widget _buildCard(String title, String content, TextStyle titleStyle, TextStyle bodyStyle) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleStyle),
            const SizedBox(height: 12),
            Text(content, style: bodyStyle, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
