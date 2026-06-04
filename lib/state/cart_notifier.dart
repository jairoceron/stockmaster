import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/repositories/service/InventoryService.dart';
import 'package:stockmaster/state/report_notifier.dart';
import '../data/repositories/service/cart_groups_service.dart';

import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/cart_group.dart';
import '../state/transaction_notifier.dart';

class CartNotifier extends ChangeNotifier {
  final CartGroupsService _cartService;
  final InventoryService _inventoryService;
  final TransactionNotifier _transactionNotifier; // 👈 nuevo
  final ReportNotifier _reportNotifier; // 👈 nuevo

  CartNotifier(this._cartService,
      this._inventoryService,
      this._transactionNotifier,
      this._reportNotifier
      );

  final Map<int, List<CartItem>> _carts = {};
  List<CartGroup> _activeGroups = [];

  List<CartGroup> get activeGroups => List.unmodifiable(_activeGroups);

  // 🔹 Inicializar cargando carritos desde la BD
  Future<void> loadCartGroups() async {
    _activeGroups = await _cartService.getOpenCartGroups();
    for (var group in _activeGroups) {
      _carts[group.id] = [];
    }
    notifyListeners();
  }

  // 🔹 Crear nuevo carrito
  Future<void> createCartGroup(String? name) async {
    final group = await _cartService.createCartGroup(name);
    _activeGroups.add(group);
    _carts[group.id] = [];
    notifyListeners();
  }

  // 🔹 Obtener items de un carrito
  List<CartItem> itemsForGroup(int cartGroupId) =>
      List.unmodifiable(_carts[cartGroupId] ?? []);

  // 🔹 Total de un carrito
  double totalAmountForGroup(int cartGroupId) {
    final items = _carts[cartGroupId] ?? [];
    return items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  // 🔹 Agregar producto a un carrito específico
  void addProductToGroup(int cartGroupId, Product product, {int quantity = 1}) {
    final items = _carts.putIfAbsent(cartGroupId, () => []);
    final index = items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + quantity);
    } else {
      items.add(CartItem(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  // 🔹 Método de conveniencia: agrega al primer carrito activo
  void addProduct(Product product, {int quantity = 1}) {
    if (_activeGroups.isEmpty) return;
    final firstGroup = _activeGroups.first;
    addProductToGroup(firstGroup.id, product, quantity: quantity);
  }

  // 🔹 Aumentar cantidad
  void increaseQuantity(int cartGroupId, Product product) {
    final items = _carts[cartGroupId];
    if (items == null) return;

    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
      notifyListeners();
    }
  }

  // 🔹 Disminuir cantidad
  void decreaseQuantity(int cartGroupId, Product product) {
    final items = _carts[cartGroupId];
    if (items == null) return;

    final index = items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0 && items[index].quantity > 1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
    } else if (index >= 0) {
      items.removeAt(index);
    }
    notifyListeners();
  }

  // 🔹 Eliminar producto
  void removeProduct(int cartGroupId, Product product) {
    final items = _carts[cartGroupId];
    if (items == null) return;

    items.removeWhere((item) => item.product.id == product.id);
    notifyListeners();
  }

  // 🔹 Vaciar carrito
  void clearCart(int cartGroupId) {
    _carts[cartGroupId] = [];
    notifyListeners();
  }

  // 🔹 Procesar carrito con persistencia (reduce stock y registra transacciones)
  Future<void> processCartGroup(int cartGroupId, String userId) async {
    print("➡️ Ingresa a processCartGroup ... ");
    final items = _carts[cartGroupId] ?? [];
    if (items.isEmpty) return;

    // Persistencia en BD: reduce stock y registra transacciones
    await _inventoryService.processCartGroup(cartGroupId, userId, items);
    print("➡️ _inventoryService.processCartGroup ... ");

    // Marcar carrito como procesado en memoria
    final groupIndex = _activeGroups.indexWhere((g) => g.id == cartGroupId);
    if (groupIndex >= 0) {
      _activeGroups[groupIndex] =
          _activeGroups[groupIndex].copyWith(processed: true);
    }

    // Vaciar carrito en memoria
    _carts[cartGroupId] = [];
    notifyListeners();
    print("➡️ notifyListeners en cart_notifier ... ");

    // 🔹 Refrescar transacciones automáticamente
    await _transactionNotifier.refreshAfterPurchase();
    print("✅ Transacciones refrescadas tras compra");


    // 🔹 Refrescar reportes
    await _reportNotifier.loadTodaySales();
    print("✅ Reportes refrescados tras compra");
    print("✅ Reportes refrescados tras compra");



  }

  // 🔹 Actualizar estado de sincronización
  Future<void> syncCartGroup(int cartGroupId, {required bool status, String? state}) async {
    await _cartService.updateSyncStatus(cartGroupId, status: status, state: state);
    notifyListeners();
  }

  // 🔹 Eliminar carrito
  Future<void> deleteCartGroup(int cartGroupId) async {
    await _cartService.deleteCartGroup(cartGroupId);
    _activeGroups.removeWhere((g) => g.id == cartGroupId);
    _carts.remove(cartGroupId);
    notifyListeners();
  }
}
