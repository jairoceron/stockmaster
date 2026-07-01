
import 'package:flutter/material.dart';

class InventoryTypeProvider extends ChangeNotifier {
  String _inventoryType = '';
  String get inventoryType => _inventoryType;

  void setInventoryType(String type) {
    _inventoryType = type;
    notifyListeners();
  }
}
