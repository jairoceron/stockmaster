import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as provider;
import 'package:stockmaster/screens/sale/quick_sale_form_screen.dart';
import '../helpers/product_image_helper.dart';
import '../providers/sales_notifier.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    super.initState();
    // 🔹 Forzar carga inicial de TODAS las ventas con join hacia clientes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = provider.Provider.of<SalesNotifier>(context, listen: false);
      notifier.loadSalesDirectWithClients(); // 👈 ahora usa el método con join
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Gestión de Ventas",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Resumen de ventas del día
            provider.Consumer<SalesNotifier>(
              builder: (context, notifier, _) {
                final sales = List<Map<String, dynamic>>.from(notifier.history);
                sales.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));

                final today = DateTime.now();
                final totalToday = sales
                    .where((s) =>
                (s['date'] as DateTime).year == today.year &&
                    (s['date'] as DateTime).month == today.month &&
                    (s['date'] as DateTime).day == today.day)
                    .fold<double>(0, (sum, s) => sum + (s['price'] ?? 0));

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.attach_money,
                        size: 40, color: Colors.green),
                    title: Text(
                      "Ventas del día",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Total: \$${totalToday.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // 🔹 Lista de ventas recientes
            Expanded(
              child: provider.Consumer<SalesNotifier>(
                builder: (context, notifier, _) {
                  final sales = List<Map<String, dynamic>>.from(notifier.history);
                  sales.sort((a, b) => (b['date'] as DateTime).compareTo(a['date'] as DateTime));

                  if (sales.isEmpty) {
                    return Center(
                      child: Text(
                        "No hay ventas registradas",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: sales.length,
                    itemBuilder: (_, i) {
                      final sale = sales[i];
                      final imageUrl = sale['imageUrl'] as String?;
                      final imageProvider = ProductImageHelper.resolve(imageUrl);

                      final isLatest = i == 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: isLatest ? Colors.lightGreen.shade100 : null,
                        child: ListTile(
                          leading: imageProvider != null
                              ? CircleAvatar(backgroundImage: imageProvider)
                              : const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(
                            "Venta #${sale['saleId'].toString().substring(0, 5)}",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Text(
                            "Cliente: ${sale['clientName']}\nTotal: \$${(sale['price'] as double).toStringAsFixed(2)}",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // 🔹 Botón principal para nueva venta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(
                  "Registrar nueva venta",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const QuickSaleFormScreen(),
                    ),
                  );

                  if (result == true) {
                    final salesNotifier = provider.Provider.of<SalesNotifier>(
                        context,
                        listen: false);
                    await salesNotifier.loadSalesDirectWithClients(); // 👈 refresca con join
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
