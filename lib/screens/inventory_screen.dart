import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/inventory_provider.dart';
import '../data/repositories/product_repository.dart';
import '../state/inventory_notifier.dart';
import 'empty_inventory_screen.dart';
import 'inventory_list_screen.dart';
import '/providers/user_provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  _InventoryScreenState createState() {
    print('>>> InventoryScreen.createState llamado');
    return _InventoryScreenState();
  }
}

class _InventoryScreenState extends State<InventoryScreen> {
  @override
  void initState() {
    super.initState();
    print('>>> InventoryScreen.initState ejecutado');
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // final user = context.read<UserProvider>().user;
     // final provider = context.read<ProductRepository>();

      /*
      if (user != null && provider.products.isEmpty) {
        print('>>> InventoryScreen: lista vacía, cargando productos');
       // provider.loadProductsForUser(user,context);
      } else {
        print('>>> InventoryScreen: lista ya tiene productos, no se reinicia');
      } */
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryNotifier>();
    final products = provider.products;
    // debugPrint("\n\n InventoryScreen() este error es una mierda  ....... $products  \n\n");
    final user = context.watch<UserProvider>().user;

    if (products.isEmpty || user == null) {
      return const EmptyInventoryScreen();
    } else {
      // ✅ Ahora InventoryListScreen solo recibe user
      return InventoryListScreen(user: user);
    }
  }
}
