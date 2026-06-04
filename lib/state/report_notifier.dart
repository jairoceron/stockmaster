import 'package:flutter/material.dart';

import '../data/repositories/transaction-service.dart';

class ReportNotifier extends ChangeNotifier {
  final TransactionService service;
  double _todaySales = 0.0;

  ReportNotifier(this.service);

  double get todaySales => _todaySales;

  Future<void> loadTodaySales() async {
    _todaySales = await service.getTodaySalesReport();
    notifyListeners();
  }
}
