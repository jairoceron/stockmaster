import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


import 'package:stockmaster/data/database/local/cart_groups_dao.dart';
import 'package:stockmaster/data/database/local/client_attributes.dart';
import 'package:stockmaster/data/database/local/client_attributes_dao.dart';
import 'package:stockmaster/data/database/local/images_stockmaster.dart';
import 'package:stockmaster/data/database/local/images_stockmaster_dao.dart';
import 'package:stockmaster/data/database/local/inventory_movements.dart';
import 'package:stockmaster/data/database/local/items.dart';
import 'package:stockmaster/data/database/local/items_dao.dart';
import 'package:stockmaster/data/database/local/product-attributes.dart';
import 'package:stockmaster/data/database/local/product_attributes_dao.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/product_lots.dart';
import 'package:stockmaster/data/database/local/product_lots_dao.dart';
import 'package:stockmaster/data/database/local/sale_items.dart';

import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:stockmaster/data/database/local/sales.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/third_parts.dart';
import 'package:stockmaster/data/database/local/third_parts_dao.dart';
import 'package:stockmaster/data/database/local/transaction_dao.dart';
import 'package:stockmaster/data/database/local/type_inventories.dart';
import 'package:stockmaster/data/database/local/type_inventories_dao.dart';
import 'package:stockmaster/data/database/local/users.dart';
import 'package:stockmaster/data/database/local/users_dao.dart';
import 'package:stockmaster/data/seed/services_seeder.dart';

import '../../../helpers/uuid_helper.dart';
import '../../seed/client_attribute_seeder.dart';
import '../../seed/type_inventory_seeder.dart';
import 'business_dao.dart';
import 'businesss.dart';
import 'inventory_movements_dao.dart';
import 'services.dart';
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
    TypeInventories,
    ProductLots,
    ThirdParts,
    ImagesStockmaster,
    Services,
    Items,
    SaleItems,
    Sales,
    InventoryMovements
  ],
  daos: [
    ProductDao,
    TransactionDao,
    CartGroupsDao,
    BusinessDao,
    UsersDao,
    ClientAttributesDao,
    ProductAttributesDao,
    TypeInventoriesDao,
    ProductLotsDao,
    ThirdPartsDao,
    ImagesStockmasterDao,
    ServicesDao,
    ItemsDao,
    SaleItemsDao,
    SalesDao,
    InventoryMovementsDao
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
      final typeInventoriesDao = TypeInventoriesDao(this);
      final seeder = TypeInventoriesSeeder(typeInventoriesDao);
      await seeder.seed();

      // Inicializar tabla de servicios si está vacía
    //  final seederServices = ServicesSeeder(servicesDao);
    //  await seederServices.seedServicesIfEmpty();
//66666


      // 👇 Inicializar el DAO de atributos
      final clientAttributesDao = ClientAttributesDao(this);
      final attrSeeder = ClientAttributeSeeder(clientAttributesDao);

// 👇 Poblar atributos de Droguería/Naturistas
      await attrSeeder.seedCategoriesAttributes();


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
    final dbPath = p.join(dir.path, 'stockmaster.sqlite');
    final file = File(dbPath);

    print('\n\n >>>>>>>>> RUTA DE LA BASE DE DATOS: DB path: ${dir.path} \n\n');
    print('\n\n >>>>>>>>> RUTA COMPLETA: ${file.path}\n\n');

    return NativeDatabase(file, logStatements: true);
  });
}
