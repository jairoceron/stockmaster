import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/company_data_form.dart';
import '/services/logout_inventario.dart';
import 'soporte_tecnico.dart';
import '/screens/product_formXX.dart';
import '/screens/home_page.dart';
import '/screens/inventory_screenXX.dart';
import '../theme/theme_provider.dart';

class BarInventario {
  static AppBar buildAppBar(
      BuildContext context,
      String title, {
        VoidCallback? onClearFilters,
        VoidCallback? onShowFilters,
      }) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    const Color backgroundColor = Colors.deepPurple;
    const Color iconColor = Colors.white;
    const Color activeColor = Colors.amberAccent;

    Widget buildIconWithLabel({
      required IconData icon,
      required String label,
      required String pageTitle,
      required VoidCallback onPressed,
    }) {
      final isActive = title == pageTitle;
      return GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? activeColor : iconColor, size: 22),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive ? activeColor : iconColor,
              ),
            ),
          ],
        ),
      );
    }

    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 4,
      actions: [
        if (onShowFilters != null)
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: "Filtros",
            onPressed: onShowFilters,
          ),
        if (onClearFilters != null)
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: "Limpiar filtros",
            onPressed: onClearFilters,
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildIconWithLabel(
                icon: Icons.home,
                label: "Home",
                pageTitle: "Home",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: "Home")),
                  );
                },
              ),
              buildIconWithLabel(
                icon: Icons.inventory,
                label: "Inventario",
                pageTitle: "Inventario",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InventoryScreenXX()),
                  );
                },
              ),
              buildIconWithLabel(
                icon: Icons.business,
                label: "Compañia",
                pageTitle: "Company",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompanyDataForm()),
                  );
                },
              ),
              buildIconWithLabel(
                icon: Icons.support_agent,
                label: "Soporte",
                pageTitle: "Soporte Técnico",
                onPressed: () {
                  SoporteTecnico.abrirWhatsApp(context);
                },
              ),
              buildIconWithLabel(
                icon: Icons.logout,
                label: "Salir",
                pageTitle: "Logout",
                onPressed: () => LogoutInventario.ejecutarLogout(context),
              ),
              buildIconWithLabel(
                icon: Icons.add_box,
                label: "Productos",
                pageTitle: "Add Product",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductFormXX()),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  final isDark = themeProvider.themeMode != ThemeMode.dark;
                  themeProvider.toggleTheme(isDark);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.wb_sunny
                          : Icons.nightlight_round,
                      color: activeColor,
                      size: 22,
                    ),
                    const Text(
                      "Tema",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
