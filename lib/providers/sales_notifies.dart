import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import '../data/database/local/app_database.dart';
import '/data/database/local/third_parts.dart';

class SalesNotifier extends ChangeNotifier {
  final SalesDao salesDao;
  final SaleItemsDao saleItemsDao;
  final ServicesDao servicesDao;

  ThirdPartEntity client; // 👈 cliente actual

  List<Map<String, dynamic>> _history = [];
  Map<String, dynamic>? _lastInserted;

  List<Map<String, dynamic>> get history => _history;
  Map<String, dynamic>? get lastInserted => _lastInserted;

  SalesNotifier({
    required this.salesDao,
    required this.saleItemsDao,
    required this.servicesDao,
    required this.client,
  }) {
    _loadHistory();
  }

  /// Permite cambiar el cliente en tiempo de ejecución
  void setClient(ThirdPartEntity newClient) {
    client = newClient;
    _loadHistory();
  }

  /// Carga el historial completo de ventas del cliente
  Future<void> _loadHistory() async {
    final sales = await salesDao.getSalesByClient(client.id);
    sales.sort((a, b) => b.date.compareTo(a.date));

    final List<Map<String, dynamic>> history = [];
    for (final sale in sales) {
      final items = await saleItemsDao.getItemsBySale(sale.id);
      for (final item in items) {
        final service = await servicesDao.getServiceById(item.serviceId);
        history.add({
          'date': sale.date,
          'serviceName': service?.name ?? 'Servicio',
          'price': item.subtotal,
          'saleId': sale.id,
        });
      }
    }
    _history = history;
    notifyListeners();
  }

  /// Inserta un nuevo registro en memoria y notifica a los listeners
  Future<void> addSaleRecord(Map<String, dynamic> record) async {
    _lastInserted = record;
    _history.insert(0, record); // lo pone de primeras en la lista
    notifyListeners();
  }

  /// Refresca el historial desde la base de datos
  Future<void> refreshHistory() async {
    await _loadHistory();
  }
}
