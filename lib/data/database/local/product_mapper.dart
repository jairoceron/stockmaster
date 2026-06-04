import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/products.dart';
import 'package:stockmaster/models/product.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:uuid/uuid.dart';

extension ProductEntityMapper on Product {
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? "",
      idbusiness: idbusiness,
      idcategory: idcategory,
      name: name,
      image: image,
      stock: stock,
      price: price,
      owner: owner,
      barcode: barcode,
      stockminimumlevel: stockminimumlevel,
      deviceid: deviceid,
      platform: platform,
      createdat: createdat,
      syncstatus: syncstatus ?? false,
      lastsyncedat: lastsyncedat,
      syncstate: syncstate ?? "",
      ubicacion: ubicacion,
      bodega: bodega,
      isdemo: isdemo ?? false, // 👈 agregado
    );
  }
}

extension ProductMapper on Product {
  /// Convierte Product a ProductsCompanion para inserción
  ProductsCompanion toInsertCompanion() {
    return ProductsCompanion.insert(
      id: Value(id ?? const Uuid().v4()),
      idbusiness: Value(idbusiness),
      idcategory: Value(idcategory),
      name: Value(name),
      image: Value(image),
      stock: Value(stock),
      price: Value(price),
      createdat: Value(createdat),
      owner: Value(owner),
      barcode: Value(barcode),
      stockminimumlevel: Value(stockminimumlevel),
      deviceid: Value(deviceid),
      platform: Value(platform),
      syncstatus: Value(syncstatus ?? false),
      lastsyncedat: Value(lastsyncedat),
      syncstate: Value(syncstate ?? ""),
      ubicacion: Value(ubicacion),
      bodega: Value(bodega),
      isdemo: Value(isdemo ?? false), // 👈 agregado
    );
  }

  /// Convierte Product a ProductsCompanion para actualización
  ProductsCompanion toUpdateCompanion() {
    assert(id != null && id!.isNotEmpty, 'El id no puede ser null al actualizar');
    return ProductsCompanion(
      // ❌ No incluir id aquí
      idbusiness: idbusiness == null ? const Value.absent() : Value(idbusiness!),
      idcategory: idcategory == null ? const Value.absent() : Value(idcategory!),
      name: name == null ? const Value.absent() : Value(name!),
      image: image == null ? const Value.absent() : Value(image!),
      stock: stock == null ? const Value.absent() : Value(stock!),
      price: Value(price),
      createdat: createdat == null ? const Value.absent() : Value(createdat!),
      owner: owner == null ? const Value.absent() : Value(owner!),
      barcode: barcode == null ? const Value.absent() : Value(barcode!),
      stockminimumlevel: stockminimumlevel == null ? const Value.absent() : Value(stockminimumlevel!),
      deviceid: deviceid == null ? const Value.absent() : Value(deviceid!),
      platform: platform == null ? const Value.absent() : Value(platform!),
      syncstatus: Value(syncstatus ?? false),
      lastsyncedat: lastsyncedat == null ? const Value.absent() : Value(lastsyncedat!),
      syncstate: Value(syncstate ?? ""),
      ubicacion: ubicacion == null ? const Value.absent() : Value(ubicacion!),
      bodega: bodega == null ? const Value.absent() : Value(bodega!),
      isdemo: Value(isdemo ?? false),
    );
  }


  /// Convierte Product a ProductEntity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id ?? '',
      idbusiness: idbusiness,
      idcategory: idcategory,
      name: name,
      image: image,
      stock: stock,
      price: price,
      createdat: createdat,
      owner: owner,
      barcode: barcode,
      stockminimumlevel: stockminimumlevel,
      deviceid: deviceid,
      platform: platform,
      syncstatus: syncstatus ?? false,
      lastsyncedat: lastsyncedat,
      syncstate: syncstate ?? "",
      ubicacion: ubicacion,
      bodega: bodega,
      isdemo: isdemo ?? false, // 👈 agregado
    );
  }

  /// Convierte ProductEntity (de Drift) a Product
  static Product fromEntity(ProductEntity entity) {
    return Product(
      id: entity.id,
      idbusiness: entity.idbusiness,
      idcategory: entity.idcategory,
      name: entity.name ?? '',
      image: entity.image,
      stock: entity.stock ?? 0,
      price: entity.price ?? 0.0,
      createdat: entity.createdat,
      owner: entity.owner,
      barcode: entity.barcode,
      stockminimumlevel: entity.stockminimumlevel,
      deviceid: entity.deviceid,
      platform: entity.platform,
      syncstatus: entity.syncstatus,
      lastsyncedat: entity.lastsyncedat,
      syncstate: entity.syncstate,
      ubicacion: entity.ubicacion,
      bodega: entity.bodega,
      isdemo: entity.isdemo, // 👈 agregado
    );
  }

  /// Convierte Product a ProductsCompanion con nullToAbsent
  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      idbusiness: idbusiness == null ? const Value.absent() : Value(idbusiness!),
      idcategory: idcategory == null ? const Value.absent() : Value(idcategory!),
      name: name == null ? const Value.absent() : Value(name!),
      image: image == null ? const Value.absent() : Value(image!),
      stock: stock == null ? const Value.absent() : Value(stock!),
      price: Value(price),
      createdat: createdat == null ? const Value.absent() : Value(createdat!),
      owner: owner == null ? const Value.absent() : Value(owner!),
      barcode: barcode == null ? const Value.absent() : Value(barcode!),
      stockminimumlevel: stockminimumlevel == null ? const Value.absent() : Value(stockminimumlevel!),
      deviceid: deviceid == null ? const Value.absent() : Value(deviceid!),
      platform: platform == null ? const Value.absent() : Value(platform!),
      ubicacion: ubicacion == null ? const Value.absent() : Value(ubicacion!),
      bodega: bodega == null ? const Value.absent() : Value(bodega!),
      syncstatus: Value(syncstatus ?? false),
      lastsyncedat: lastsyncedat == null ? const Value.absent() : Value(lastsyncedat!),
      syncstate: Value(syncstate ?? ""),
      isdemo: Value(isdemo ?? false), // 👈 agregado
    );
  }
}
