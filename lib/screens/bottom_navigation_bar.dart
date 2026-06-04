import 'package:flutter/material.dart';
import 'package:stockmaster/screens/support/help_support_screen.dart';
import 'package:stockmaster/ui/widgets/transactions/transaction_list_screen.dart' show TransactionListScreen;
import '/screens/inventory_screen.dart';

import '../ui/widgets/inventory_with_form_screen.dart';
import '/presentation/report/report_screen.dart';
import '/screens/add_user_screen.dart';

/// Clase que representa cada item de navegación
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
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Lista unificada de items y pantallas
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
    // 👇 Eliminado el tab de Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: navItems.map((e) => e.screen).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            .map((e) => BottomNavigationBarItem(icon: e.icon, label: e.label))
            .toList(),
      ),
    );
  }
}
