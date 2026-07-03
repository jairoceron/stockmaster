import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import '../../data/database/local/app_database.dart';
import '../../providers/sales_notifies.dart';
import '/data/database/local/third_parts.dart';

import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/screens/services/services_selection_screen.dart';
import '/data/database/local/third_parts.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:provider/provider.dart' ;
import 'package:google_fonts/google_fonts.dart';

/// ✅ Pantalla de historial de ventas/compras
class SalesHistoryScreen extends StatefulWidget {
  final SalesDao salesDao;
  final SaleItemsDao saleItemsDao;
  final ServicesDao servicesDao;
  final ThirdPartEntity client;

  const SalesHistoryScreen({
    super.key,
    required this.salesDao,
    required this.saleItemsDao,
    required this.servicesDao,
    required this.client,
  });

  @override
  State<SalesHistoryScreen> createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _loadHistory();
  }

  Future<List<Map<String, dynamic>>> _loadHistory() async {
    final sales = await widget.salesDao.getSalesByClient(widget.client.id);
    sales.sort((a, b) => b.date.compareTo(a.date)); // más reciente primero

    final List<Map<String, dynamic>> history = [];

    for (final sale in sales) {
      final items = await widget.saleItemsDao.getItemsBySale(sale.id);

      for (final item in items) {
        final service = await widget.servicesDao.getServiceById(item.serviceId);
        history.add({
          'date': sale.date,
          'serviceName': service?.name ?? 'Servicio',
          'price': item.subtotal,
        });
      }
    }
    return history;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SalesNotifier>(
      builder: (context, notifier, child) {
        final history = notifier.history;
        if (history.isEmpty) {
          return const Center(child: Text("No hay historial registrado"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: history.length,
          itemBuilder: (context, index) {
            final record = history[index];
            final date = record['date'] as DateTime;
            final serviceName = record['serviceName'] as String;
            final price = record['price'] as double;

            final isLastInserted = notifier.lastInserted != null &&
                notifier.lastInserted!['saleId'] == record['saleId'];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: isLastInserted ? 6 : 3,
              color: isLastInserted ? Colors.yellow.shade100 : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute.toString().padLeft(2, '0')}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      serviceName,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${price.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
