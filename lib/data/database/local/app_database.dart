import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:stockmaster/data/database/local/cart_groups_dao.dart';
import 'package:stockmaster/data/database/local/client_attributes.dart';
import 'package:stockmaster/data/database/local/client_attributes_dao.dart';
import 'package:stockmaster/data/database/local/product-attributes.dart';
import 'package:stockmaster/data/database/local/product_attributes_dao.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/transaction_dao.dart';
import 'package:stockmaster/data/database/local/users.dart';
import 'package:stockmaster/data/database/local/users_dao.dart';

import '../../../helpers/uuid_helper.dart';
import 'business_dao.dart';
import 'businesss.dart';
import 'cart_groups.dart';
import 'products.dart';
import 'transactions.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Products,
    Transactions,
    CartGroups,
    Businesss,
    Users,
    ClientAttributes,
    ProductAttributes,
  ],
  daos: [
    ProductDao,
    TransactionDao,
    CartGroupsDao,
    BusinessDao,
    UsersDao,
    ClientAttributesDao,
    ProductAttributesDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      print('\n\n >>>>>>>>> Creando todas las tablas en onCreate() \n\n');
      await m.createAll();
      print('\n\n >>>>>>>>> Tablas creadas correctamente \n\n');

      // 👇 Si quieres insertar datos iniciales:
      // await into(products).insert(ProductsCompanion.insert(
      //   id: UuidHelper.newUuid(),
      //   name: 'Producto demo',
      //   stock: 10,
      //   isdemo: true,
      // ));
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'app.sqlite');
    final file = File(dbPath);

    print('\n\n >>>>>>>>> RUTA DE LA BASE DE DATOS: DB path: ${dir.path} \n\n');
    print('\n\n >>>>>>>>> RUTA COMPLETA: ${file.path}\n\n');

    return NativeDatabase(file, logStatements: true);
  });
}
