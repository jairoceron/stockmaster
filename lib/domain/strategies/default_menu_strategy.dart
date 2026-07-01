
import 'package:flutter/material.dart';
import 'package:stockmaster/controllers/inventory_controller.dart';
import 'package:stockmaster/controllers/product_lot_controller.dart';
import 'package:stockmaster/domain/strategies/menu_strategy.dart';
import 'package:stockmaster/models/product.dart';

class DefaultMenuStrategy implements MenuStrategy {
  @override
  List<PopupMenuEntry<String>> buildMenu(Product product, InventoryController controller, BuildContext context) {
    return [
      const PopupMenuItem(
        value: 'edit',
        child: ListTile(leading: Icon(Icons.edit, color: Colors.blue), title: Text('Editar')),
      ),
      const PopupMenuItem(
        value: 'delete',
        child: ListTile(leading: Icon(Icons.delete, color: Colors.red), title: Text('Eliminar')),
      ),
    ];
  }
}