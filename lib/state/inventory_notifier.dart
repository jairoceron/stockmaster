import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/repositories/product_repository.dart';

class InventoryNotifier extends ChangeNotifier {
  final ProductRepository repository;

  InventoryNotifier(this.repository);

  final List<Product> _filteredProducts = []; // lista filtrada (UI)
  final List<Product> _allProducts = [];      // lista completa
  int _page = 0;
  final int _pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;

  List<Product> get products => _filteredProducts;

  Future<void> loadProducts() async {

    try {

      final items = await repository.getAllProducts();
      _allProducts
        ..clear()
        ..addAll(items);

      debugPrint('\n root_screen.dart ... loadProducts ... step 000 ');

      _filteredProducts
        ..clear()
        ..addAll(items);

      debugPrint('\n root_screen.dart ... loadProducts ... step 001 ');

      notifyListeners();

    } catch (e, stack) {
      debugPrint('Failed to load products: $e\n$stack');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      debugPrint('\n\n\n inventory_notifier ... addProduct ... step 00_0 ${product}  \n\n\n');

      final newProduct = await repository.add(product);

      debugPrint('\n\n\n inventory_notifier ... addProduct ... step 00_1 newProduct  \n\n\n');

      _allProducts.insert(0, newProduct);

      debugPrint('\n\n\n inventory_notifier ... addProduct ... step 00_2 $newProduct   \n\n\n ');

      _filteredProducts.insert(0, newProduct);

      debugPrint('\n\n\n inventory_notifier en.dart ... addProduct ... step 00_3 $newProduct   \n\n\n ');

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Failed to add product: $e\n$stack');
    }
  }

  void clearFilters() {
    _filteredProducts
      ..clear()
      ..addAll(_allProducts);
    notifyListeners();
  }

  void updateFilteredProducts(List<Product> filtered) {
    _filteredProducts
      ..clear()
      ..addAll(filtered);
    notifyListeners();
  }

  void resetPagination() {
    _page = 0;
    hasMore = true;
    _filteredProducts.clear();
    _allProducts.clear();
    notifyListeners();
  }

  void searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered = _allProducts.where(
          (p) => (p.name ?? '').toLowerCase().contains(lowerQuery),
    ).toList();

    _filteredProducts
      ..clear()
      ..addAll(filtered);

    // 🔑 Si no hay resultados, restaurar todos
    if (_filteredProducts.isEmpty) {
      _filteredProducts.addAll(_allProducts);
    }

    notifyListeners();
  }

  void filterByCategory(String? idcategory) {
    if (idcategory == null || idcategory == 'Todas') {
      clearFilters();
    } else {
      final filtered = _allProducts
          .where((p) => p.idcategory.toString() == idcategory)
          .toList();

      _filteredProducts
        ..clear()
        ..addAll(filtered);

      // 🔑 Restaurar todos si no hay resultados
      if (_filteredProducts.isEmpty) {
        _filteredProducts.addAll(_allProducts);
      }
    }
    notifyListeners();
  }

  Future<void> modifyProduct(Product product) async {
    try {

      final modifyProduct = await repository.modifyProduct(product);
      final index = _filteredProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) _filteredProducts[index] = product;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = product;

      notifyListeners();
    } catch (e) {
      debugPrint('Error al modificar producto: $e');
      rethrow;
    }
  }

  Future<void> eliminateProduct(String id) async {
    try {
      await repository.delete(id);
      _filteredProducts.removeWhere((p) => p.id == id);
      _allProducts.removeWhere((p) => p.id == id);

      // 🔑 Si el filtro queda vacío, restaurar todos
      if (_filteredProducts.isEmpty && _allProducts.isNotEmpty) {
        _filteredProducts.addAll(_allProducts);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar producto: $e');
      rethrow;
    }
  }

  Future<void> restoreProduct(Product product) async {
    try {
      // Reinsertar en BD
      final restored = await repository.add(product);

      // Reinsertar en memoria
      _allProducts.insert(0, restored);
      _filteredProducts.insert(0, restored);

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error al restaurar producto: $e\n$stack');
      rethrow;
    }
  }


  Future<void> updateStock(Product product, int delta) async {

    debugPrint("\n\n ------- InventoryNotifier.updateStock() ..product.id === ... ${product.id}");
    try {
      final newStock = (product.stock ?? 0) + delta;
      if (newStock < 0) throw Exception("Stock no puede ser negativo");

      final updatedProduct = product.copyWith(stock: newStock);

      debugPrint("\n\n ********* InventoryNotifier() ..... updatedProduct  $updatedProduct   \n\n");
      product = await repository.modifyProduct(updatedProduct);




      final index = _filteredProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) _filteredProducts[index] = updatedProduct;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = updatedProduct;

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error en updateStock: $e\n$stack');
      rethrow;
    }
  }



  Future<void> borrarRegistrosDeDemo() async {
    debugPrint('\n\n borrarRegistrosDeDemo() ... eliminando productos demo \n\n');
    try {
      // 🔹 Borrar en la base de datos
      await repository.deleteDemoProducts();

      // 🔹 Borrar en memoria
      _allProducts.removeWhere((p) => p.isdemo == true);
      _filteredProducts.removeWhere((p) => p.isdemo == true);

      // 🔑 Si el filtro queda vacío pero aún hay productos en _allProducts,
      // restauramos todos para que la UI no quede vacía
      if (_filteredProducts.isEmpty && _allProducts.isNotEmpty) {
        _filteredProducts.addAll(_allProducts);
      }

      // 🔹 Notificar a la UI
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error al borrar productos demo: $e\n$stack');
      rethrow;
    }
  }

}
