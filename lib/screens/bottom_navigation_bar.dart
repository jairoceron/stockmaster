import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stockmaster/screens/support/help_support_screen.dart';
import 'package:stockmaster/ui/widgets/transactions/transaction_list_screen.dart'
    show TransactionListScreen;
import '/screens/inventory_screen.dart';
import '../ui/widgets/inventory_with_form_screen.dart';
import '/presentation/report/report_screen.dart';
import '/screens/add_user_screen.dart';

class BottomNavItem {
  final Icon icon;
  final String label;
  final Widget screen;

  BottomNavItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    if (Platform.isAndroid || Platform.isIOS) {
      // 🔹 Crear y cargar el banner
      _bannerAd = BannerAd(
        adUnitId: 'ca-app-pub-3940256099942544/6300978111', // 👈 ID de prueba
        size: AdSize.banner, // altura ~50px
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) => setState(() {}),
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
      )..load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  final List<BottomNavItem> navItems = [
    BottomNavItem(
      icon: const Icon(Icons.inventory_2),
      label: "Inventory",
      screen: const InventoryScreen(),
    ),
    BottomNavItem(
      icon: const Icon(Icons.output_sharp),
      label: "Salidas Inventario",
      screen: const InventoryWithFormScreen(),
    ),
    BottomNavItem(
      icon: const Icon(Icons.bar_chart),
      label: "Reports",
      screen: const ReportScreen(),
    ),
    BottomNavItem(
      icon: const Icon(Icons.group),
      label: "Users",
      screen: const AddUserScreen(),
    ),
    BottomNavItem(
      icon: const Icon(Icons.list_alt),
      label: "Support",
      screen: const HelpSupportScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: navItems.map((e) => e.screen).toList(),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_bannerAd != null)
            Container(
              alignment: Alignment.center,
              width: _bannerAd!.size.width.toDouble(),
              height: _bannerAd!.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            elevation: 0,
            items: navItems
                .map(
                  (e) => BottomNavigationBarItem(icon: e.icon, label: e.label),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
