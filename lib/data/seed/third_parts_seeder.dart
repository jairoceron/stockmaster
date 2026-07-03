import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/third_parts_dao.dart';
import '/helpers/uuid_helper.dart';

class ThirdPartsSeeder {
  final ThirdPartsDao thirdPartsDao;

  ThirdPartsSeeder(this.thirdPartsDao);

  /// Método principal: si la tabla está vacía, carga los datos desde el JSON
  Future<void> seedClientsIfEmpty() async {
    final existing = await thirdPartsDao.getAllThirdParts();
    if (existing.isNotEmpty) {
      return; // Ya hay registros, no hace nada
    }

    // Leer archivo JSON desde assets
    final jsonString = await rootBundle.loadString('assets/avatar/clientes.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Insertar cada cliente en la tabla
    for (var item in jsonData) {
      final client = ThirdPartEntity(
        id: generateUuid(),
        name: item['name'] as String,
        phone: item['phone'].toString(), // convertir a String
        imageUrl: item['imageUrl'] as String?,
        thirdPartType: 'cliente', // marcamos tipo
        createdAt: DateTime.now(),
      );

      await thirdPartsDao.insertThirdPart(client);
    }
  }
}
