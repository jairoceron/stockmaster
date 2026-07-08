import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/third_parts_dao.dart';
import 'package:stockmaster/data/seed/services_seeder.dart';
import 'package:stockmaster/data/seed/third_parts_seeder.dart';

class SeedInitializer {
  static Future<void> seed(AppDatabase db) async {
    final servicesDao = ServicesDao(db);
    final seeder = ServicesSeeder(servicesDao);
    await seeder.seedServicesIfEmpty();

    final thirdPartsDao = ThirdPartsDao(db);
    final seederThirdPart = ThirdPartsSeeder(thirdPartsDao);
    await seederThirdPart.seedClientsIfEmpty();
  }
}
