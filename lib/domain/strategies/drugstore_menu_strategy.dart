import 'package:flutter/material.dart';
import 'package:stockmaster/controllers/product_lot_controller.dart';
import 'package:stockmaster/domain/strategies/default_menu_strategy.dart';
import 'package:stockmaster/models/product.dart';

import '../../controllers/inventory_controller.dart';

class DrugstoreMenuStrategy extends DefaultMenuStrategy {
  @override
  List<PopupMenuEntry<String>> buildMenu(Product product, InventoryController controller, BuildContext context) {
    final baseMenu = super.buildMenu(product, controller, context);
    baseMenu.insert(1, const PopupMenuItem(
      value: 'lot',
      child: ListTile(leading: Icon(Icons.qr_code, color: Colors.orange), title: Text('Lote')),
    ));
    return baseMenu;
  }
}