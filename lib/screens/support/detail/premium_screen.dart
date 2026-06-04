import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("premium_title".tr()),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              "premium_inventory_migration".tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "premium_inventory_migration_desc".tr(),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 24),

            _featureCard(
              icon: Icons.table_chart,
              color: Colors.green,
              title: "premium_excel_title".tr(),
              description: "premium_excel_desc".tr(),
              buttonText: "premium_excel_button".tr(),
              onPressed: () {
                // Acción para descargar plantilla
              },
            ),

            _featureCard(
              icon: Icons.qr_code_scanner,
              color: Colors.orange,
              title: "premium_systems_title".tr(),
              description: "premium_systems_desc".tr(),
            ),

            _featureCard(
              icon: Icons.cloud_sync,
              color: Colors.blue,
              title: "premium_sync_title".tr(),
              description: "premium_sync_desc".tr(),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                // Acción para activar premium
              },
              child: Text(
                "premium_activate_button".tr(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.black54)),
            if (buttonText != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(buttonText),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
