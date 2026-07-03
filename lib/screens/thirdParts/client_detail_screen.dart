import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/screens/services/services_selection_screen.dart';
import '../services/sales_history_screen.dart';
import '/data/database/local/third_parts.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:provider/provider.dart';
import '../../providers/sales_notifies.dart';

class ClientDetailScreen extends StatelessWidget {
  final ThirdPartEntity entity;
  final ServicesDao servicesDao;

  const ClientDetailScreen({
    super.key,
    required this.entity,
    required this.servicesDao,
  });

  @override
  Widget build(BuildContext context) {
    final salesDao = Provider.of<SalesDao>(context, listen: false);
    final saleItemsDao = Provider.of<SaleItemsDao>(context, listen: false);

    return ChangeNotifierProvider(
      create: (_) => SalesNotifier(
        salesDao: salesDao,
        saleItemsDao: saleItemsDao,
        servicesDao: servicesDao,
        client: entity,
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(entity.name),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Info"),
                Tab(text: "Historial"),
                Tab(text: "Notas"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildInfoTab(),
              _buildHistoryTab(salesDao, saleItemsDao),
              _buildNotesTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Email: ${entity.email ?? ''}"),
        Text("Teléfono: ${entity.phone ?? ''}"),
        Text("Tipo: ${entity.thirdPartType ?? ''}"),
        Text("Dirección: ${entity.address ?? ''}"),
      ],
    );
  }

  Widget _buildHistoryTab(SalesDao salesDao, SaleItemsDao saleItemsDao) {
    return Column(
      children: [
        Expanded(
          child: SalesHistoryScreen(
            salesDao: salesDao,
            saleItemsDao: saleItemsDao,
            servicesDao: servicesDao,
            client: entity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (innerContext) {
              return ElevatedButton(
                onPressed: () {
                  // ✅ Usamos innerContext, que sí está dentro del árbol del provider
                  final notifier = innerContext.read<SalesNotifier>();

                  Navigator.push(
                    innerContext,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: notifier,
                        child: ServicesSelectionScreen(
                          servicesDao: servicesDao,
                          salesDao: salesDao,
                          saleItemsDao: saleItemsDao,
                          client: entity,
                        ),
                      ),
                    ),
                  );
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
                  "Registrar Servicio",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNotesTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(entity.notes ?? "Sin notas"),
    );
  }
}
