import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../repositories/exceptions/duplicateproductexception.dart';
import '../repositories/product_repository.dart';
import '/models/product.dart';
import 'package:uuid/uuid.dart';

class InventoryInitializer {
  final ProductRepository repository; // ✅ usa la abstracción

  InventoryInitializer(this.repository);
  final uuid = const Uuid().v4();

  Future<void> seedInitialProducts() async {
    final products = [
      Product(
        idbusiness: uuid,
        idcategory: uuid,
        name: "Cepillo Colgate",
        image: "colgate1.png",
        stock: 100,
        price: 52000.0,
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
        owner: '',
        barcode: '',
        stockminimumlevel: 10,
        deviceid: '',
        platform: 'android',
      ),
      Product(
        idbusiness: uuid,
        idcategory: uuid,
        name: "Laptop Acer",
        image: "colgate2.png",
        stock: 100,
        price: 52000.0,
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
        owner: '',
        barcode: '',
        stockminimumlevel: 10,
        deviceid: '',
        platform: 'android',
      ),
      Product(
        idbusiness: uuid,
        idcategory: uuid,
        name: "iPhone 15",
        image: "colgate3.png",
        stock: 100,
        price: 52000.0,
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
        owner: '',
        barcode: '',
        stockminimumlevel: 10,
        deviceid: '',
        platform: 'android',
      ),
      Product(
        idbusiness: uuid,
        idcategory: uuid,
        name: "Silla reclinable",
        image: "colgate4.png",
        stock: 100,
        price: 52000.0,
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
        owner: '',
        barcode: '',
        stockminimumlevel: 10,
        deviceid: '',
        platform: 'android',
      ),
      Product(
        idbusiness: uuid,
        idcategory: uuid,
        name: "Escritorio",
        image: "colgate5.png",
        stock: 100,
        price: 52000.0,
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
        owner: '',
        barcode: '',
        stockminimumlevel: 10,
        deviceid: '',
        platform: 'android',
      ),
    ];

    /*
    for (final product in products) {
      try {
        await repository.add(product); // ✅ usa la abstracción
      } on DuplicateProductException {
        debugPrint("producto duplicado: ${product.id}");
      }
    }
    */
  }
}
