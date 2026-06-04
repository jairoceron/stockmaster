import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../data/database/local/app_database.dart';
import '../data/database/local/client_attributes_dao.dart';
import '../data/database/local/product_attributes_dao.dart';
import '../models/product.dart';
import '/data/database/local/product_mapper.dart';

class AttributeNotifier extends ChangeNotifier {
  final AppDatabase db;
  final ClientAttributesDao dao;
  List<ClientAttributesEntity> clientAttributes = [];

  AttributeNotifier(this.db, this.dao);


  Future<void> loadAttributesForClient(String clientType) async {
    clientAttributes = await dao.getAttributesByBusinessType(clientType);
    notifyListeners();
  }
  void setAttributeValueBusiness(String fieldName, String value) {
    // guardar el valor en un mapa interno
  }

  List<ProductAttributeEntity> _attributes = [];
  Map<String, String> _attributeValues = {};

  List<ProductAttributeEntity> get attributes => _attributes;
  Map<String, String> get attributeValues => _attributeValues;

  /// Cargar atributos según el tipo de inventario
  Future<void> loadAttributesByInventoryType(String inventoryType) async {
    _attributes = await db.productAttributesDao
        .getAttributesByInventoryType(inventoryType);
    notifyListeners();
  }

  /// Guardar valor dinámico en memoria temporal
  void setAttributeValue(String fieldName, String value) {
    _attributeValues[fieldName] = value;
    notifyListeners();
  }

  /// Guardar producto y sus atributos en la BD
  Future<void> addProduct(Product product) async {
    // 👇 Generar UUID para el producto
    final productId = const Uuid().v4();

    // Insertar producto con id explícito
    await db.productDao.insertProductId(
      product.toCompanion(true).copyWith(
        id: Value(productId),
      ),
    );

    // Insertar atributos vinculados al producto
    for (final attr in _attributes) {
      final value = _attributeValues[attr.fieldName] ?? "";
      await db.productAttributesDao.insertAttribute(
        ProductAttributesCompanion.insert(
          productId: productId, // 👈 ahora es String
          fieldName: attr.fieldName,
          fieldType: attr.fieldType,
          fieldValue: value,
        ),
      );
    }
  }
}
