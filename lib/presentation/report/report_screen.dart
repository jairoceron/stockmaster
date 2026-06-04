import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/DTO/ReportSummaryDTO.dart';
import '../../state/report_notifier.dart';
import '/presentation/report/report_controller.dart';
import '../../../state/transaction_notifier.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ReportController>().updateSummaryFromLocal();
      context.read<TransactionNotifier>().loadTransactions();
      context.read<ReportNotifier>().loadTodaySales();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ReportController>();
    final summary = controller.summary;
    final reportNotifier = context.watch<ReportNotifier>();

    final titleStyle = GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    );

    final valueStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: Colors.black87,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("reports_title".tr(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: summary == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              context,
              "inventory_title".tr(),
              _buildSummaryUI(summary, titleStyle, valueStyle),
            ),
            const SizedBox(height: 16),
            _buildCard(
              context,
              "sales_title".tr(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$${reportNotifier.todaySales.toStringAsFixed(2)}",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await context.read<ReportNotifier>().loadTodaySales();
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text("sales_update_button".tr(), style: GoogleFonts.poppins()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Widget content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryUI(ReportSummaryDTO summary, TextStyle titleStyle, TextStyle valueStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("inventory_total_products".tr(namedArgs: {"count": summary.totalProductos.toString()}), style: valueStyle),
        Text("inventory_total_stock".tr(namedArgs: {"count": summary.stockTotal.toString()}), style: valueStyle),
        Text("inventory_total_value".tr(namedArgs: {"value": summary.valorTotal.toStringAsFixed(2)}), style: valueStyle),
      ],
    );
  }
}
