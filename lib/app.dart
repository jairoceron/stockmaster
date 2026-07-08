import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stockmaster/presentation/report/report_screen.dart';
import 'package:stockmaster/screens/SplashScreen.dart';
import 'package:stockmaster/screens/bottom_navigation_bar.dart';
import 'package:stockmaster/screens/guest_screen.dart';
import 'package:stockmaster/screens/login_screen.dart';
import 'package:stockmaster/screens/product_form.dart';
import 'package:stockmaster/ui/widgets/inventory_with_form_screen.dart';
import 'data/seed/InventoryInitializer.dart';
import 'theme/app_theme.dart';
import 'screens/root_screen_new.dart';

import 'data/repositories/product_repository.dart';
import 'package:provider/provider.dart';

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
            '/mainProduct': (context) => const ProductForm(), // 👈 aquí está
          },
        );
      },
    );
  }
}
