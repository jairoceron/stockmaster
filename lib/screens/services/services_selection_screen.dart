import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/sales.dart';
import 'package:stockmaster/data/database/local/sale_items.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import '../../providers/sales_notifier.dart';
import '/data/database/local/third_parts.dart';
import '/helpers/uuid_helper.dart';
import 'package:provider/provider.dart';

class ServicesSelectionScreen extends StatefulWidget {
  final ServicesDao servicesDao;
  final SalesDao salesDao;
  final SaleItemsDao saleItemsDao;
  final ThirdPartEntity client;

  const ServicesSelectionScreen({
    super.key,
    required this.servicesDao,
    required this.salesDao,
    required this.saleItemsDao,
    required this.client,
  });

  @override
  State<ServicesSelectionScreen> createState() => _ServicesSelectionScreenState();
}

class _ServicesSelectionScreenState extends State<ServicesSelectionScreen> {
  late Future<List<ServiceEntity>> _servicesFuture;
  final Map<String, bool> _selectedServices = {};

  @override
  void initState() {
    super.initState();
    _servicesFuture = widget.servicesDao.getAllServices();
  }

  double _calculateTotal(List<ServiceEntity> services) {
    final selectedIds = _selectedServices.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    final selectedServices = services.where((s) => selectedIds.contains(s.id)).toList();

    return selectedServices.fold<double>(
      0.0,
          (sum, s) => sum + (s.price ?? 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Servicios de ${widget.client.name}"),
      ),
      body: FutureBuilder<List<ServiceEntity>>(
        future: _servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final services = snapshot.data ?? [];
          if (services.isEmpty) {
            return const Center(child: Text("No hay servicios registrados"));
          }

          final total = _calculateTotal(services);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    final isSelected = _selectedServices[service.id] ?? false;

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              _selectedServices[service.id] = value ?? false;
                            });
                          },
                        ),
                        title: Text(
                          service.name ?? "Sin nombre",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          "\$${service.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                color: Colors.blue.shade50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total acumulado:",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            final selectedIds = _selectedServices.entries
                .where((entry) => entry.value)
                .map((entry) => entry.key)
                .toList();

            if (selectedIds.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Seleccione al menos un servicio")),
              );
              return;
            }

            final services = await widget.servicesDao.getAllServices();
            final selectedServices = services.where((s) => selectedIds.contains(s.id)).toList();

            // ✅ Calcular total
            final total = selectedServices.fold<double>(
              0.0,
                  (sum, s) => sum + (s.price ?? 0.0),
            );

            // ✅ Crear venta
            final sale = SalesCompanion.insert(
              id: Value(generateUuid()),
              clientId: widget.client.id,
              date: Value(DateTime.now()),
              paymentMethod: const Value("efectivo"),
              totalAmount: total,
            );
            await widget.salesDao.insertSale(sale);

            // ✅ Insertar ítems
            for (final service in selectedServices) {
              final item = SaleItemsCompanion.insert(
                id: Value(generateUuid()),
                saleId: sale.id.value,
                serviceId: service.id,
                price: service.price ?? 0.0,
                quantity: Value(1),
                subtotal: service.price ?? 0.0,
              );
              await widget.saleItemsDao.insertSaleItem(item);
            }

            // ✅ Notificar al SalesNotifier compartido
            final notifier = context.read<SalesNotifier>();
            notifier.addSaleRecord({
              'date': DateTime.now(),
              'serviceName': selectedServices.first.name ?? 'Servicio',
              'price': total,
              'saleId': sale.id.value,
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Venta registrada con ${selectedServices.length} servicios")),
            );

            Navigator.pop(context); // volver al detalle del cliente
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Registrar",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
