import 'package:flutter/material.dart';
import '/screens/ingreso_inventario_screen.dart';
import '../../models/transaction.dart';

import 'package:flutter/material.dart';
import '/screens/ingreso_inventario_screen.dart';
import '../../../models/transaction.dart'; // tu modelo de dominio Transaction

class NavigationHelpers {
  static Future<void> navigateToIngresoInventario({
    required BuildContext context,
    required Map<String, dynamic> product,
    required String transactionType,
    int amount = 10,
    String note = "normal",
    String user = "genius@genius.com.co",
    required Function(int newQuantity) onQuantityUpdated,
  }) async {
    final newQuantity = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngresoInventarioScreen(
          product: product,
          transaction: Transaction(
            id: null, // se asigna automáticamente en la BD
            productId: product['id'],
            cartGroupId: product['cartGroupId'] ?? 0, // 👈 nuevo campo obligatorio
            transactionType: transactionType,
            quantity: amount,
            unitPrice: product['unitPrice'] ?? 0.0,
            totalAmount: (product['unitPrice'] ?? 0.0) * amount,
            concept: "$note $transactionType",
            userId: 1, // o el id del usuario autenticado
            platform: "mobile",
            createdAt: DateTime.now(),
            syncStatus: false,
            lastSyncedAt: null, // 👈 nuevo campo
            syncState: "pending", // 👈 nuevo campo
          ),
        ),
      ),
    );

    if (newQuantity != null) {
      onQuantityUpdated(newQuantity);
    }
  }
}
