import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 👈 Import Riverpod
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stockmaster/core/InicializationCompany.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:stockmaster/data/repositories/service/InventoryService.dart';
import 'package:stockmaster/presentation/report/report_controller.dart';
import 'package:stockmaster/providers/BusinessProvider.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';
import 'package:stockmaster/screens/SplashScreen.dart';
import 'package:stockmaster/screens/product_form.dart';
import 'package:stockmaster/screens/root_screen_new.dart';
import 'package:stockmaster/services/initializers/amplify_initializer.dart';
import 'package:stockmaster/state/cart_notifier.dart';
import 'package:stockmaster/state/inventory_notifier.dart';
import 'package:stockmaster/state/report_notifier.dart';
import 'package:stockmaster/state/services_form_view_model_notifier.dart';
import 'package:stockmaster/state/transaction_notifier.dart';

import 'data/database/local/business_dao.dart';
import 'data/database/local/client_attributes_dao.dart';
import 'data/database/local/product_dao.dart';
import 'data/database/local/product_lots_dao.dart';
import 'data/database/local/transaction_dao.dart';
import 'data/database/local/type_inventories_dao.dart';
import 'data/repositories/service/ReportService.dart';
import 'data/repositories/service/SQLiteTransactionService.dart';
import 'data/repositories/service/cart_groups_service.dart';
import 'data/repositories/transaction-service.dart';
import 'data/seed/DatabaseInitializer.dart';
import 'data/repositories/product_repository.dart';
import 'data/seed/InventoryInitializer.dart';
import 'data/seed/type_inventory_seeder.dart';
import 'providers/user_provider.dart';
import 'providers/inventory_provider.dart';
import 'theme/theme_provider.dart';
import 'theme/app_theme.dart';

import 'data/database/local/app_database.dart';
import 'data/database/local/cart_groups.dart';
import 'data/database/local/cart_groups_dao.dart';
import 'data/report/repositories/report_repository_impl.dart';

import 'services/amplify_product_service.dart';
import 'data/repositories/sqlite_product_service.dart';
import 'services/user_services.dart';

import 'screens/root_screen.dart';
import 'screens/login_screen.dart';
import 'screens/bottom_navigation_bar.dart';
import 'ui/widgets/inventory_with_form_screen.dart';
import 'screens/guest_screen.dart';
import '/presentation/report/report_screen.dart';
import 'package:stockmaster/state/attribute_notifier.dart';
import 'core/borrar_base_datos.dart';
import 'package:flutter/foundation.dart';

// 👇 Importación de easy_localization
import 'package:easy_localization/easy_localization.dart';

// 👇 Importación de ServicesDao y ViewModel
import 'data/database/local/services_dao.dart';
import 'data/repositories/services_repository.dart';


Future<void> initDatabase() async {
  // tu lógica de initDatabase
}

Future<void> main() async {
  if (kDebugMode) {
    // await resetDatabase();
  }

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  await initHiveForFlutter();
  await AmplifyInitializer.configure();
  await initDatabase();

  final client = ValueNotifier(
    GraphQLClient(
      link: HttpLink("https://.../graphql"),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  final reportRepository = ReportRepositoryImpl(baseUrl: "https://.../graphql");
  final userProvider = UserProvider();
  userProvider.setGuestUser();

  final db = AppDatabase();
  final businessDao = BusinessDao(db);

  final typeInventoriesDao = TypeInventoriesDao(db);
  final transactionDao = TransactionDao(db);
  final transactionService = SQLiteTransactionService(transactionDao);
  final cartGroupsDao = CartGroupsDao(db);
  final cartGroupsService = CartGroupsService(cartGroupsDao);
  final inventoryService = InventoryService(db);
  final productDao = ProductDao(db);
  final reportService = ReportService(productDao);
  final businessProvider = BusinessProvider();
  final inventoryTypeProvider = InventoryTypeProvider();

  final initCompany = InicializationCompany(
    db: db,
    userProvider: userProvider,
    businessProvider: businessProvider,
    inventoryTypeProvider: inventoryTypeProvider,
    businessDao: businessDao,
  );

  await initCompany.initSession();

  final reportNotifier = ReportNotifier(TransactionService(TransactionDao(db)));

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope( // 👈 Riverpod ProviderScope agregado
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: GraphQLProvider(
          client: client,
          child: provider.MultiProvider(
            providers: [
              provider.ChangeNotifierProvider(create: (_) => userProvider),
              provider.Provider<AppDatabase>(create: (_) => db),
              provider.Provider<ProductDao>(create: (_) => ProductDao(db)),
              provider.Provider<ProductLotsDao>(create: (_) => ProductLotsDao(db)),
              provider.Provider<BusinessDao>(create: (_) => BusinessDao(db)),
              provider.Provider<TypeInventoriesDao>(create: (_) => TypeInventoriesDao(db)),
              // 👇 Nuevo provider para ServicesDao
              provider.Provider<ServicesDao>(create: (_) => ServicesDao(db)),
              // 👇 Nuevo provider para ServicesRepository
              provider.Provider<ServicesRepository>(
                create: (context) => ServicesRepository(context.read<ServicesDao>()),
              ),
              // 👇 Nuevo ChangeNotifierProvider para ServiceFormViewModelNotifier
              provider.ChangeNotifierProvider<ServiceFormViewModelNotifier>(
                create: (context) => ServiceFormViewModelNotifier(
                  context.read<ServicesRepository>(),
                ),
              ),
              provider.Provider<ProductRepository>(
                create: (context) {
                  final user = provider.Provider.of<UserProvider>(context, listen: false).user;
                  if (user.isGuest) {
                    final db = provider.Provider.of<AppDatabase>(context, listen: false);
                    return SQLiteProductService(db);
                  } else {
                    return AmplifyProductService(client.value);
                  }
                },
              ),
              provider.ChangeNotifierProvider(create: (_) => ThemeProvider()),
              provider.ChangeNotifierProvider(create: (_) => ReportNotifier(TransactionService(TransactionDao(AppDatabase())))),
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
                  final db = provider.Provider.of<AppDatabase>(context, listen: false);
                  final clientAttributesDao = ClientAttributesDao(db);
                  return AttributeNotifier(db, clientAttributesDao);
                },
              ),
              provider.ChangeNotifierProvider.value(value: inventoryTypeProvider),
              provider.ChangeNotifierProvider(create: (_) => BusinessProvider()),
            ],
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return provider.Consumer<ProductRepository>(
      builder: (context, productRepository, _) {
        return MaterialApp(
          title: 'Stock Master',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: FutureBuilder(
            future: InventoryInitializer(productRepository).seedInitialProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              return const RootScreenNew();
            },
          ),
          routes: {
            '/addProduct': (context) => const InventoryWithFormScreen(),
            '/reports': (context) => const ReportScreen(),
            '/home': (context) => const BottomNavBar(),
            '/login': (context) => const LoginScreen(),
            '/guest': (context) => const GuestScreen(),
            '/mainProduct': (context) => const ProductForm(),
          },
        );
      },
    );
  }
}
