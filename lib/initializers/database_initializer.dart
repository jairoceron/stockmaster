import 'package:stockmaster/data/database/local/app_database.dart';

class DatabaseInitializer {
  static Future<AppDatabase> initDatabase() async {
    final db = AppDatabase();
    // Aquí puedes agregar migraciones o lógica extra
    return db;
  }
}
