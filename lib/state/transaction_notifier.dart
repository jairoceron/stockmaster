import 'package:flutter/material.dart';
import '../data/repositories/service/SQLiteTransactionService.dart';
import '../models/transaction.dart';

class TransactionNotifier extends ChangeNotifier {
  final SQLiteTransactionService service;
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

  TransactionNotifier(this.service);

  /// 🔹 Cargar todas las transacciones desde la BD
  Future<void> loadTransactions() async {
    print("📊 Cargando transacciones desde BD...");
    _transactions = await service.getTransactions();
    print("✅ ${_transactions.length} transacciones cargadas");
    notifyListeners();
  }

  /// 🔹 Insertar nueva transacción y refrescar lista
  Future<void> addTransaction(Transaction tx) async {
    print("📝 Insertando transacción en BD...");
    final newTx = await service.addTransaction(tx);
    _transactions.insert(0, newTx);
    print("✅ Transacción insertada con id ${newTx.id}");
    notifyListeners();
  }

  /// 🔹 Eliminar transacción y refrescar lista
  Future<void> deleteTransaction(int id) async {
    print("🗑️ Eliminando transacción $id...");
    await service.deleteTransaction(id);
    _transactions.removeWhere((t) => t.id == id);
    print("✅ Transacción $id eliminada");
    notifyListeners();
  }

  /// 🔹 Refrescar después de procesar un carrito
  Future<void> refreshAfterPurchase() async {
    print("🔄 Refrescando transacciones tras compra...");
    await loadTransactions();
  }
}
