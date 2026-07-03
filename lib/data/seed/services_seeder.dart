import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import '/helpers/uuid_helper.dart';

class ServicesSeeder {
  final ServicesDao servicesDao;

  ServicesSeeder(this.servicesDao);

  /// Método principal: si la tabla está vacía, carga los datos desde el JSON
  Future<void> seedServicesIfEmpty() async {
    final existing = await servicesDao.getAllServices();
    if (existing.isNotEmpty) {
      return; // Ya hay registros, no hace nada
    }

    // Leer archivo JSON desde assets
    final jsonString = await rootBundle.loadString('assets/servicios/servicios.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Insertar cada servicio en la tabla
    for (var item in jsonData) {
      final service = ServiceEntity(
        id: generateUuid(), // tu helper de UUID
        name: item['name'] as String?,
        price: (item['price'] as num?)?.toDouble(),
        image: item['image'] as String?,
        createdAt: DateTime.now(),
        status: 'activo',
        isDemo: true,
      );

      await servicesDao.insertService(service);
    }
  }
}
