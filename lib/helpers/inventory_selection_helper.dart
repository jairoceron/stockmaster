import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/providers/BusinessProvider.dart';
import 'package:drift/drift.dart';

class InventorySelectionHelper {
  static Future<void> updateInventoryType(
      BuildContext context,
      String selectedType,
      ) async {
    final businessDao = context.read<BusinessDao>();
    final businessProvider = context.read<BusinessProvider>();

    // Obtener el primer registro de negocio
    final business = await businessDao.getFirstBusiness();
    if (business != null) {
      // Actualizar el campo en BD
      final updatedBusiness = business.copyWith(typeinventory: Value(selectedType));
      await businessDao.updateBusiness(updatedBusiness);

      // Actualizar el provider
      businessProvider.setBusiness(updatedBusiness);

      debugPrint("✅ Tipo de inventario actualizado a: $selectedType");
    } else {
      debugPrint("⚠️ No se encontró registro de negocio en BD");
    }
  }
}
