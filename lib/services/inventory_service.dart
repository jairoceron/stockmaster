// 4. Service layer
import '../data/repositories/product_repository.dart';
import '../models/product.dart';
// import '../repositories/product_repository.dart';

class InventoryService {
  final ProductRepository repository;

  InventoryService(this.repository);

  Future<void> addProduct(Product product) async {
    print(" Inventory service InventoryService  ddd");
    if ((product.stock ?? 0)< 0) throw Exception("Stock no puede ser negativo");
    await repository.add(product);
  }
}