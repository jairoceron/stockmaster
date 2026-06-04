import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../data/repositories/product_repository.dart';
import '../services/amplify_product_service.dart';

class InventoryProviderXX extends ChangeNotifier {
  final AmplifyProductService service;
  final GraphQLClient client;   // cliente GraphQL inyectado

  final List<Product> _products = [];      // lista filtrada (lo que ve la UI)
  final List<Product> _allProducts = [];   // fuente de verdad (todos los productos)

  int _page = 0;
  final int _pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;

  List<Product> get products => List.unmodifiable(_products);

  InventoryProviderXX(this.service, this.client);

  StreamSubscription<QueryResult>? _subscription;

  /// Inicia la suscripción una sola vez al loguearse el usuario
  void startSubscription(int idBusiness) {
    if (_subscription != null) return; // evita duplicar

    final subscriptionDoc = gql(r'''
      subscription OnInventorySummaryUpdated($idbusiness: String!) {
        onInventorySummaryUpdated(idbusiness: $idbusiness) {
          totalProductos
          stockTotal
          valorTotal
        }
      }
    ''');

    _subscription = client.subscribe(
      SubscriptionOptions(
        document: subscriptionDoc,
        variables: {"idbusiness": idBusiness},
      ),
    ).listen((result) {
      if (result.hasException) {
        debugPrint("❌ >>>>>>> Error en suscripción: ${result.exception}");
        return;
      }
      if (result.data != null) {
        final summary = result.data!['onInventorySummaryUpdated'];
        debugPrint("📡 Evento recibido: $summary");
        // Aquí podrías actualizar un estado interno con el resumen
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  /// Reinicia la paginación y limpia listas
  void resetPagination() {
    _page = 0;
    hasMore = true;
    _products.clear();
    _allProducts.clear();
    notifyListeners();
  }

  /// Buscar productos por nombre
  void searchProducts(String query) {
    final lowerQuery = query.toLowerCase();
    final filtered = _allProducts.where(
          (p) => (p.name ?? '').toLowerCase().contains(lowerQuery),
    ).toList();

    _products
      ..clear()
      ..addAll(filtered.isNotEmpty ? filtered : _allProducts);

    notifyListeners();
  }

  /// Filtrar por categoría
  void filterByCategory(String? idcategory) {
    if (idcategory == null || idcategory == 'Todas') {
      clearFilters();
    } else {
      final filtered = _allProducts.where((p) => p.idcategory.toString() == idcategory).toList();
      _products
        ..clear()
        ..addAll(filtered.isNotEmpty ? filtered : _allProducts);
    }
    notifyListeners();
  }

  /// Filtros con lógica AND
  void applyAdvancedFiltersAND({
    required double minPrice,
    required double maxPrice,
    required double minStock,
  }) {
    final filtered = _allProducts.where((p) =>
    (p.price ?? 0) >= minPrice &&
        (p.price ?? 0) <= maxPrice &&
        (p.stock ?? 0) >= minStock,
    ).toList();

    _products
      ..clear()
      ..addAll(filtered.isNotEmpty ? filtered : _allProducts);

    notifyListeners();
  }

  /// Filtros con lógica OR
  void applyAdvancedFiltersOR({
    required double minPrice,
    required double maxPrice,
    required double minStock,
  }) {
    final filtered = _allProducts.where((p) =>
    ((p.price ?? 0) >= minPrice && (p.price ?? 0) <= maxPrice) ||
        (p.stock ?? 0) >= minStock,
    ).toList();

    _products
      ..clear()
      ..addAll(filtered.isNotEmpty ? filtered : _allProducts);

    notifyListeners();
  }

  /// Restaurar lista inicial
  void clearFilters() {
    _products
      ..clear()
      ..addAll(_allProducts);
    notifyListeners();
  }

  /// Actualizar lista filtrada desde estrategias externas
  void updateFilteredProducts(List<Product> filtered) {
    _products
      ..clear()
      ..addAll(filtered);
    notifyListeners();
  }

  /// Añadir producto remoto (Aurora/Postgres)
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await service.addProduct(product);
      _products.insert(0, newProduct);
      _allProducts.insert(0, newProduct);
      notifyListeners();
    } catch (e, stack) {
      debugPrint('Failed to add product: $e\n$stack');
    }
  }

  /// Método auxiliar para claridad: delega en addProduct
  Future<void> addProductRemote(Product product) async {
    return addProduct(product);
  }

  /// Añadir producto local (SQLite o lista interna)
  Future<void> addProductLocal(Product product) async {
    try {
      // Aquí podrías integrar SQLite; por ahora se simula con la lista interna
      _products.insert(0, product);
      _allProducts.insert(0, product);
      notifyListeners();
      debugPrint("✅ Producto guardado localmente: ${product.name}");
    } catch (e, stack) {
      debugPrint('Failed to add local product: $e\n$stack');
    }
  }

  /// Cargar productos con paginación

  /// Actualizar stock
  Future<void> updateStock(Product product, int delta) async {
    try {
      final newStock = (product.stock ?? 0) + delta;
      if (newStock < 0) throw Exception("Stock no puede ser negativo");

      final updatedProduct = await service.updateProductStock(product.id!, newStock);

      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) _products[index] = updatedProduct;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = updatedProduct;

      notifyListeners();
    } catch (e, stack) {
      debugPrint('Error en updateStock: $e\n$stack');
      rethrow;
    }
  }

  /// Modificar producto
  Future<void> modifyProduct(Product product) async {
    try {
      final updated = await service.modifyProduct(product);

      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) _products[index] = updated;

      final allIndex = _allProducts.indexWhere((p) => p.id == product.id);
      if (allIndex != -1) _allProducts[allIndex] = updated;

      notifyListeners();
    } catch (e) {
      debugPrint('Error al modificar producto: $e');
      rethrow;
    }
  }

  /// Eliminar producto
  Future<void> eliminateProduct(int id) async {
    try {
      await service.eliminateProduct(id);
      _products.removeWhere((p) => p.id == id);
      _allProducts.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar producto: $e');
      rethrow;
    }
  }
}
