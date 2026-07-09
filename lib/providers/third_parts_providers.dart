import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:stockmaster/state/third_parts_notifier.dart';
import '../data/database/local/app_database.dart';
import '../data/database/local/third_parts_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockmaster/data/database/local/third_parts.dart';


// Provider para la base de datos
  final appDatabaseProvider = Provider<AppDatabase>((ref) {
    return AppDatabase();
  });

// Provider para el DAO de terceros
  final thirdPartsDaoProvider = Provider<ThirdPartsDao>((ref) {
    final db = ref.watch(appDatabaseProvider);
    return ThirdPartsDao(db);
  });

// Provider para el Notifier que maneja el estado de terceros
final thirdPartsNotifierProvider =
NotifierProvider<ThirdPartsNotifier, List<ThirdPartEntity>>(() {
  return ThirdPartsNotifier();
});


/// Provider que mantiene el cliente seleccionado en memoria.
/// Ahora expone directamente un ThirdPartEntity? en lugar de ThirdPart?.
final selectedClientProvider =
StateProvider<ThirdPartEntity?>((ref) => null);