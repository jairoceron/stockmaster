import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stockmaster/core/InicializationCompany.dart';

import 'package:stockmaster/data/repositories/service/InventoryService.dart' show InventoryService;
import 'package:stockmaster/presentation/report/report_controller.dart';
import 'package:stockmaster/screens/SplashScreen.dart';
import 'package:stockmaster/screens/product_form.dart';
import 'package:stockmaster/services/initializers/amplify_initializer.dart';
import 'package:stockmaster/state/cart_notifier.dart';
import 'package:stockmaster/state/inventory_notifier.dart';
import 'package:stockmaster/state/report_notifier.dart';
import 'package:stockmaster/state/transaction_notifier.dart';

import 'data/database/local/business_dao.dart';
import 'data/database/local/client_attributes_dao.dart';
import 'data/database/local/product_dao.dart';
import 'data/database/local/transaction_dao.dart';
import 'data/repositories/service/ReportService.dart';
import 'data/repositories/service/SQLiteTransactionService.dart';
import 'data/repositories/service/cart_groups_service.dart';
import 'data/repositories/transaction-service.dart';
import 'data/seed/DatabaseInitializer.dart';
import 'data/repositories/product_repository.dart';
import 'data/seed/InventoryInitializer.dart';
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

Future<void> initDatabase() async {
  // tu lógica de initDatabase
}

Future<void> main() async {
  if (kDebugMode) {
    // await resetDatabase();
  }

  WidgetsFlutterBinding.ensureInitialized();

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
  final transactionDao = TransactionDao(db);
  final transactionService = SQLiteTransactionService(transactionDao);
  final cartGroupsDao = CartGroupsDao(db);
  final cartGroupsService = CartGroupsService(cartGroupsDao);
  final inventoryService = InventoryService(db);
  final productDao = ProductDao(db);
  final reportService = ReportService(productDao);

  final initCompany = InicializationCompany(db: db, userProvider: userProvider);
  await initCompany.initSession();

  final reportNotifier = ReportNotifier(TransactionService(TransactionDao(db)));

  // 👇 Inicialización de EasyLocalization
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'assets/translations', // ruta de tus archivos JSON
      fallbackLocale: const Locale('en'),
      child: GraphQLProvider(
        client: client,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => userProvider),
            Provider<AppDatabase>(create: (_) => db),
            Provider<ProductDao>(create: (_) => ProductDao(db)),
            Provider<BusinessDao>(create: (_) => BusinessDao(db)),
            Provider<ProductRepository>(
              create: (context) {
                final user = Provider.of<UserProvider>(context, listen: false).user;
                if (user.isGuest) {
                  final db = Provider.of<AppDatabase>(context, listen: false);
                  return SQLiteProductService(db);
                } else {
                  return AmplifyProductService(client.value);
                }
              },
            ),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => ReportNotifier(TransactionService(TransactionDao(AppDatabase())))),
            ChangeNotifierProvider(create: (_) => ReportController(reportService)),
            ChangeNotifierProvider(
              create: (context) {
                final repo = Provider.of<ProductRepository>(context, listen: false);
                final notifier = InventoryNotifier(repo);
                notifier.loadProducts();
                return notifier;
              },
            ),
            ChangeNotifierProvider(create: (_) => TransactionNotifier(transactionService)),
            ChangeNotifierProvider(
              create: (context) {
                final transactionNotifier = Provider.of<TransactionNotifier>(context, listen: false);
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
            ChangeNotifierProvider(
              create: (context) {
                final db = Provider.of<AppDatabase>(context, listen: false);
                final clientAttributesDao = ClientAttributesDao(db);
                return AttributeNotifier(db, clientAttributesDao);
              },
            ),
          ],
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductRepository>(
      builder: (context, productRepository, _) {
        return MaterialApp(
          title: 'Stock Master',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          // 👇 Configuración de localización
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,

          home: FutureBuilder(
            future: InventoryInitializer(productRepository).seedInitialProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              return const RootScreen();
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
