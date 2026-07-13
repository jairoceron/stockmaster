import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stockmaster/providers/user_provider.dart';

import 'initializers/database_initializer.dart';
import 'initializers/amplify_initializer.dart';
import 'initializers/graphql_initializer.dart';
import 'initializers/seed_initializer.dart';
import 'initializers/providers_initializer.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid || Platform.isIOS) {
    await MobileAds.instance.initialize();
  }

  // Inicializa Hive para GraphQL
  await initHiveForFlutter();

  // Inicializadores
  final db = await DatabaseInitializer.initDatabase();
  await AmplifyInitializer.configure();
  final client = GraphQLInitializer.initClient();
  await SeedInitializer.seed(db);

  final userProvider = UserProvider();
  userProvider.setGuestUser();

  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: GraphQLProvider(
          client: client,
          child: provider.MultiProvider(
            providers: ProvidersInitializer.build(db, client, userProvider),
            child: const MyApp(),
          ),
        ),
      ),
    ),
  );
}
