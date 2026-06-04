// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_attributes_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductAttributesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductsTable get products => attachedDatabase.products;
  $ProductAttributesTable get productAttributes =>
      attachedDatabase.productAttributes;
  ProductAttributesDaoManager get managers => ProductAttributesDaoManager(this);
}

class ProductAttributesDaoManager {
  final _$ProductAttributesDaoMixin _db;
  ProductAttributesDaoManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db.attachedDatabase, _db.products);
  $$ProductAttributesTableTableManager get productAttributes =>
      $$ProductAttributesTableTableManager(
        _db.attachedDatabase,
        _db.productAttributes,
      );
}
