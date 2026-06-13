import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:stockmaster/data/database/local/product_mapper.dart';

import 'package:stockmaster/data/repositories/product_repository.dart';
import 'package:stockmaster/models/product.dart';
import '/data/database/local/product_mapper.dart';

import 'exceptions/DuplicateProductException.dart';

class SQLiteProductService implements ProductRepository {
  final AppDatabase db;
  final ProductDao dao;

  SQLiteProductService(this.db) : dao = ProductDao(db);

  @override
  Future<List<Product>> getAll(int idbusiness, int limit, int offset) async {
    final rows = await db.select(db.products).get();
    return rows.map((row) => ProductMapper.fromEntity(row)).toList();
  }

  Future<int> deleteDemoProducts() {
    return dao.deleteDemoProducts();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final rows = await db.select(db.products).get();
    return rows.map((row) => ProductMapper.fromEntity(row)).toList();
  }

  @override
  Future<Product> add(Product product) async {
    if (product.stock != null && product.stock! < 0) {
      throw Exception("Stock no puede ser negativo");
    }

    try {
      // Insertar usando Companion
      final insertedEntity = await dao.insertProductEntity(
        product.toInsertCompanion(),
      );

      // Asegurarse de devolver un Product con id String
      return ProductMapper.fromEntity(insertedEntity);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 1555) {
        throw DuplicateProductException(product.id);
      }
      rethrow;
    }
  }

  @override
  Future<void> delete(String id) async {
    await dao.deleteProduct(id);
  }

  @override
  Future<Product> updateProductStock(String id, int newStock) async {
    await (db.update(db.products)..where((tbl) => tbl.id.equals(id))).write(
      ProductsCompanion(stock: Value(newStock)),
    );

    final row = await (db.select(
      db.products,
    )..where((tbl) => tbl.id.equals(id))).getSingle();

    return ProductMapper.fromEntity(row);
  }

  Future<Product> modifyProduct(Product product) async {
    debugPrint("\n\n  !!!!! SQLITE ProductService ...... **** ${product} \n\n");
    debugPrint(
      "\n\n  +++++ SQLITE ProductService ...... **** ${product.id} -- stock ${product.stock} \n\n",
    );

    if (product.id == null || product.id!.isEmpty) {
      throw Exception("No se puede actualizar un producto sin id");
    }

    // Actualizar registro usando Companion
    await (db.update(db.products)..where((tbl) => tbl.id.equals(product.id!)))
        .write(product.toUpdateCompanion());

    // Volver a leer el registro actualizado
    final row = await (db.select(
      db.products,
    )..where((tbl) => tbl.id.equals(product.id!))).getSingleOrNull();

    if (row == null) {
      throw Exception("No se encontró el producto con id ${product.id}");
    }

    debugPrint("\n\n  ##### SQLITE ProductService ...... **** ${row} \n\n");

    return ProductMapper.fromEntity(row);
  }

  @override
  Stream<Product> subscribeToProductAdded() {
    return db
        .select(db.products)
        .watch()
        .map((rows) => rows.map(ProductMapper.fromEntity))
        .expand((list) => list);
  }

  Future<List<Product>> fetchProductsByBusinessPaginated({
    required String idbusiness,
    int limit = 20,
    int offset = 0,
  }) async {
    final query = (db.select(db.products)
      ..where((tbl) => tbl.idbusiness.equals(idbusiness))
      ..limit(limit, offset: offset));

    final rows = await query.get();
    return rows.map((row) => ProductMapper.fromEntity(row)).toList();
  }

  /// Contar productos de forma eficiente
  Future<int> countProducts() async {
    try {
      return await dao.countProductsEfficient();
    } catch (e) {
      debugPrint("❌ Error contando productos: $e");
      return 0;
    }
  }

  Future<void> deleteAllProducts() async {
    try {
      await dao.deleteAllProducts();
    } catch (e) {
      debugPrint("❌ Error deleteAllProductos(): $e");
    }
  }
}
