

import '../../models/product.dart';


abstract class ProductRepository {
  Future<List<Product>> getAll( int idbusiness, int limit , int offset );

  Future<List<Product>> getAllProducts(); // principalmente para la base de datos local la remota si
  // tiene que filtrarse por idbusiness

  Future<Product> add(Product product);

  Future<void> delete(String id);

  // Métodos adicionales para mantener paridad con Amplify
  Future<Product> updateProductStock(String id, int newStock);
  Future<Product> modifyProduct(Product product);
  Stream<Product> subscribeToProductAdded();
  Future<List<Product>> fetchProductsByBusinessPaginated({
    required String idbusiness,
    int limit,
    int offset,
  });

  Future<int> deleteDemoProducts();

  Future<void> deleteAllProducts();



}

