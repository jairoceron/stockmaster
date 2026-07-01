import 'package:flutter/material.dart';
import 'package:stockmaster/controllers/inventory_controller.dart';
import 'package:stockmaster/controllers/product_lot_controller.dart';
import 'package:stockmaster/models/product.dart';
import 'package:stockmaster/models/product_lot.dart';

abstract class MenuStrategy {
  List<PopupMenuEntry<String>> buildMenu(Product product, InventoryController controller, BuildContext context);
}