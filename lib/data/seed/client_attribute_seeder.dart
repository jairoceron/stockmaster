import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/client_attributes.dart';
import 'package:stockmaster/data/database/local/client_attributes_dao.dart';
import 'package:drift/drift.dart';
import '../database/local/app_database.dart';

class ClientAttributeSeeder {
  final ClientAttributesDao dao;

  ClientAttributeSeeder(this.dao);

  Future<void> seedCategoriesAttributes() async {
    // Verificar si ya existen atributos para Droguería
    final existing = await dao.getAttributesByBusinessType("Droguería / Naturistas");
    if (existing.isNotEmpty) {
      return; // Ya poblado, no repetir
    }

    // Insertar atributos iniciales
    await dao.insertAttribute(ClientAttributesCompanion.insert(
      clientType: "Droguería / Naturistas",
      fieldName: "Principio activo",
      fieldType: "text",
      isRequired: const Value(true),
      displayOrder: const Value(1),
    ));

    await dao.insertAttribute(ClientAttributesCompanion.insert(
      clientType: "Droguería / Naturistas",
      fieldName: "Concentración",
      fieldType: "text", // ej 500 mg 10%
      isRequired: const Value(true),
      displayOrder: const Value(2),
    ));

    await dao.insertAttribute(ClientAttributesCompanion.insert(
      clientType: "Droguería / Naturistas",
      fieldName: "Forma farmacéutica",  //Tableta, Jarabe, Cápsula
      fieldType: "text",
      isRequired: const Value(false),
      displayOrder: const Value(3),
    ));
  }
}
