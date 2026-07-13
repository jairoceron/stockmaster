import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/products.dart';

import '../data/database/local/app_database.dart';
import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/products.dart';

class SaleStateNotifier extends ChangeNotifier {
  final Map<String, int> _selected = {}; // 🔥 usar id como clave
  final Map<String, ProductEntity> _productsCache = {}; // cache para cálculos
  double _total = 0.0;
  bool _manualOverride = false;

  Map<String, int> get selectedProducts => _selected;
  double get total => _total;
  bool get manualOverride => _manualOverride;

  void registerProducts(List<ProductEntity> products) {
    for (var p in products) {
      _productsCache[p.id] = p;
    }
  }

  void toggleProduct(ProductEntity product, bool selected) {
    if (selected) {
      _selected[product.id] = 1;
    } else {
      _selected.remove(product.id);
    }
    if (!_manualOverride) _recalculateTotal();
  }

  void updateQuantity(ProductEntity product, int qty) {
    _selected[product.id] = qty;
    if (!_manualOverride) _recalculateTotal();
  }

  void _recalculateTotal() {
    _total = 0.0;
    _selected.forEach((id, qty) {
      final product = _productsCache[id];
      if (product != null) {
        _total += (product.price ?? 0.0) * qty;
      }
    });
    notifyListeners();
  }

  void setManualTotal(double value) {
    _manualOverride = true;
    _total = value;
    notifyListeners();
  }

  void resetManualOverride() {
    _manualOverride = false;
    _recalculateTotal();
  }

  List<Map<String, dynamic>> getSelectedItems() {
    return _selected.entries.map((entry) {
      final id = entry.key;
      final qty = entry.value;
      final product = _productsCache[id];
      return {
        'product': product,
        'quantity': qty,
        'subtotal': (product?.price ?? 0.0) * qty,
      };
    }).toList();
  }
}
