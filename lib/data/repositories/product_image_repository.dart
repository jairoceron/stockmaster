

import 'package:stockmaster/data/database/local/product_dao.dart';

class ProductImageRepository {
  final ProductDao dao;

  ProductImageRepository(this.dao);

  Future<void> updateProductImage(String productId, String imagePath) async {
    await dao.updateProductImage(productId, imagePath);
  }
}
