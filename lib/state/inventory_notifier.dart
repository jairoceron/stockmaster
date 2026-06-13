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
  int get productCount => _allProducts.length;

  Future<void> loadProducts() async {
    try {
      final items = await repository.getAllProducts();
      _allProducts
        ..clear()
        ..addAll(items);

      _filteredProducts
        ..clear()
        ..addAll(items);

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Failed to load products: $e\n$stack');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await repository.add(product);
      _allProducts.insert(0, newProduct);
      _filteredProducts.insert(0, newProduct);
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
      if (index != -1) _filteredProducts[index] = modifyProduct;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = modifyProduct;

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
      final restored = await repository.add(product);
      _allProducts.insert(0, restored);
      _filteredProducts.insert(0, restored);
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error al restaurar producto: $e\n$stack');
      rethrow;
    }
  }

  Future<void> updateStock(Product product, int delta) async {
    try {
      final newStock = (product.stock ?? 0) + delta;
      if (newStock < 0) throw Exception("Stock no puede ser negativo");

      final updatedProduct = product.copyWith(stock: newStock);
      final saved = await repository.modifyProduct(updatedProduct);

      final index = _filteredProducts.indexWhere((p) => p.id == product.id);
      if (index != -1) _filteredProducts[index] = saved;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = saved;

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error en updateStock: $e\n$stack');
      rethrow;
    }
  }

  Future<void> borrarRegistrosDeDemo() async {
    try {
      await repository.deleteDemoProducts();
      _allProducts.removeWhere((p) => p.isdemo == true);
      _filteredProducts.removeWhere((p) => p.isdemo == true);

      if (_filteredProducts.isEmpty && _allProducts.isNotEmpty) {
        _filteredProducts.addAll(_allProducts);
      }

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error al borrar productos demo: $e\n$stack');
      rethrow;
    }
  }

  /// 🔹 Nuevo método para borrar todos los productos
  Future<void> deleteAllProducts() async {
    try {
      await repository.deleteAllProducts();
      _allProducts.clear();
      _filteredProducts.clear();
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error al borrar todos los productos: $e\n$stack');
      rethrow;
    }
  }
}
