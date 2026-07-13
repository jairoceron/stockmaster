import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/third_parts_dao.dart';
import 'package:stockmaster/data/seed/services_seeder.dart';
import 'package:stockmaster/data/seed/third_parts_seeder.dart';

import '../data/database/local/inventory_movements_dao.dart';
import '../data/database/local/product_dao.dart';
import '../data/seed/inventory_movement_seeder.dart';

class SeedInitializer {
  static Future<void> seed(AppDatabase db) async {
    final servicesDao = ServicesDao(db);
    final seeder = ServicesSeeder(servicesDao);
    await seeder.seedServicesIfEmpty();

    final thirdPartsDao = ThirdPartsDao(db);
    final seederThirdPart = ThirdPartsSeeder(thirdPartsDao);
    await seederThirdPart.seedClientsIfEmpty();

// Inicializar DAOs
    final productDao = ProductDao(db);
    final inventoryMovementsDao = InventoryMovementsDao(db);

    // Ejecutar seeder
    final seederInvMovement = InventoryMovementsSeeder(productDao, inventoryMovementsDao);
    await seederInvMovement.seedInventoryIfEmpty();


  }
}
