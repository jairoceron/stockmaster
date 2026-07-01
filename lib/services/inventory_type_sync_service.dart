import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';
import 'package:provider/provider.dart';

class InventoryTypeSyncService {
  static Future<void> syncFromDatabaseWithDao({
    required BusinessDao businessDao,
    required InventoryTypeProvider inventoryTypeProvider,
  }) async {
    final business = await businessDao.getFirstBusiness();
    if (business != null && business.typeinventory != null) {
      inventoryTypeProvider.setInventoryType(business.typeinventory!);
      debugPrint("✅ InventoryTypeProvider sincronizado con BD: ${business.typeinventory}");
    } else {
      debugPrint("⚠️ No se encontró registro de negocio en BD");
    }
  }
}
