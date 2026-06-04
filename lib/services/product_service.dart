import '../models/product.dart';
import '../data/repositories/product_repository.dart';

import '../state/inventory_notifier.dart';

class ProductService {
  final ProductRepository repository;
  final InventoryNotifier notifier;

  ProductService(this.repository, this.notifier);

  Future<void> saveProduct(Product product) async {
    print(" \n\n product _service.dart   saveProduct () xxxxxxProductService ZZZZ  $product \n\n" );
    // await repository.add(product);
    await notifier.addProduct(product);
  }
}
