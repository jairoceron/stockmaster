import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/single_child_widget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/product_lots_dao.dart';
import 'package:stockmaster/data/database/local/third_parts_dao.dart';
import 'package:stockmaster/data/database/local/transaction_dao.dart';
import 'package:stockmaster/data/database/local/type_inventories_dao.dart';
import 'package:stockmaster/data/database/local/cart_groups_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:stockmaster/data/database/local/client_attributes_dao.dart';
import 'package:stockmaster/data/database/local/third_parts.dart';

import 'package:stockmaster/data/repositories/product_repository.dart';
import 'package:stockmaster/data/repositories/sqlite_product_service.dart';
import 'package:stockmaster/services/amplify_product_service.dart';
import 'package:stockmaster/data/repositories/services_repository.dart';
import 'package:stockmaster/data/repositories/service/InventoryService.dart';
import 'package:stockmaster/data/repositories/service/ReportService.dart';
import 'package:stockmaster/data/repositories/service/cart_groups_service.dart';
import 'package:stockmaster/data/repositories/service/SQLiteTransactionService.dart';
import 'package:stockmaster/data/repositories/transaction-service.dart';

import 'package:stockmaster/providers/user_provider.dart';
import 'package:stockmaster/providers/inventory_provider.dart';
import 'package:stockmaster/providers/BusinessProvider.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';

import 'package:stockmaster/state/services_form_view_model_notifier.dart';
import 'package:stockmaster/state/inventory_notifier.dart';
import 'package:stockmaster/state/transaction_notifier.dart';
import 'package:stockmaster/state/cart_notifier.dart';
import 'package:stockmaster/state/report_notifier.dart';
import 'package:stockmaster/state/attribute_notifier.dart';


import 'package:stockmaster/presentation/report/report_controller.dart';
import 'package:stockmaster/theme/theme_provider.dart';

import '../providers/sales_notifier.dart';

class ProvidersInitializer {
  static List<SingleChildWidget> build(
      AppDatabase db,
      ValueNotifier<GraphQLClient> client,
      UserProvider userProvider,
      ) {
    final businessDao = BusinessDao(db);
    final typeInventoriesDao = TypeInventoriesDao(db);
    final transactionDao = TransactionDao(db);
    final transactionService = SQLiteTransactionService(transactionDao);
    final cartGroupsDao = CartGroupsDao(db);
    final cartGroupsService = CartGroupsService(cartGroupsDao);
    final inventoryService = InventoryService(db);
    final productDao = ProductDao(db);
    final reportService = ReportService(productDao);
    final inventoryTypeProvider = InventoryTypeProvider();
    final reportNotifier = ReportNotifier(TransactionService(TransactionDao(db)));

    return [
      provider.ChangeNotifierProvider(create: (_) => userProvider),
      provider.Provider<AppDatabase>(create: (_) => db),
      provider.Provider<ProductDao>(create: (_) => ProductDao(db)),
      provider.Provider<ProductLotsDao>(create: (_) => ProductLotsDao(db)),
      provider.Provider<BusinessDao>(create: (_) => BusinessDao(db)),
      provider.Provider<TypeInventoriesDao>(create: (_) => TypeInventoriesDao(db)),
      provider.Provider<ServicesDao>(create: (_) => ServicesDao(db)),
      provider.Provider<ServicesRepository>(
        create: (context) => ServicesRepository(context.read<ServicesDao>()),
      ),
      provider.ChangeNotifierProvider<ServiceFormViewModelNotifier>(
        create: (context) => ServiceFormViewModelNotifier(
          context.read<ServicesRepository>(),
        ),
      ),
      provider.Provider<SalesDao>(create: (_) => SalesDao(db)),
      provider.Provider<SaleItemsDao>(create: (_) => SaleItemsDao(db)),

      // 👇 SalesNotifier global con cliente genérico
      provider.ChangeNotifierProvider<SalesNotifier>(
        create: (_) {
          final salesDao = SalesDao(db);
          final saleItemsDao = SaleItemsDao(db);
          final servicesDao = ServicesDao(db);

          final quickClient = ThirdPartEntity(
            id: 'quick-sale-client',
            name: 'Cliente rápido',
            documentNumber: '',
            documentType: '',
            country: '',
            city: '',
            address: '',
            phone: '',
            email: '',
            instagram: '',
            notes: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            thirdPartType: '',
            imageUrl: '',
          );

          return SalesNotifier(
            salesDao: salesDao,
            saleItemsDao: saleItemsDao,
            servicesDao: servicesDao,
            client: quickClient,
          );
        },
      ),

      // 👇 ProductRepository
      provider.Provider<ProductRepository>(
        create: (context) {
          final user = provider.Provider.of<UserProvider>(context, listen: false).user;
          if (user.isGuest) {
            return SQLiteProductService(db);
          } else {
            return AmplifyProductService(client.value);
          }
        },
      ),

      provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
      provider.ChangeNotifierProvider(create: (_) => ReportNotifier(TransactionService(TransactionDao(db)))),
      provider.ChangeNotifierProvider(create: (_) => ReportController(reportService)),
      provider.ChangeNotifierProvider(
        create: (context) {
          final repo = provider.Provider.of<ProductRepository>(context, listen: false);
          final notifier = InventoryNotifier(repo);
          notifier.loadProducts();
          return notifier;
        },
      ),
      provider.ChangeNotifierProvider(create: (_) => TransactionNotifier(transactionService)),
      provider.ChangeNotifierProvider(
        create: (context) {
          final transactionNotifier = provider.Provider.of<TransactionNotifier>(context, listen: false);
          final notifier = CartNotifier(
            cartGroupsService,
            inventoryService,
            transactionNotifier,
            reportNotifier,
          );
          notifier.loadCartGroups();
          return notifier;
        },
      ),
      provider.ChangeNotifierProvider(
        create: (context) {
          final clientAttributesDao = ClientAttributesDao(db);
          return AttributeNotifier(db, clientAttributesDao);
        },
      ),
      provider.ChangeNotifierProvider.value(value: inventoryTypeProvider),
      provider.ChangeNotifierProvider(create: (_) => BusinessProvider()),
    ];
  }
}
