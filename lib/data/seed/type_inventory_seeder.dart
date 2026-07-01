import 'package:drift/drift.dart';

import '../database/local/app_database.dart';
import '../database/local/type_inventories_dao.dart';


class TypeInventoriesSeeder {
  final TypeInventoriesDao dao;

  TypeInventoriesSeeder(this.dao);

  /// Método para insertar los tipos de inventario iniciales
  Future<void> seed() async {
    // Verificar si ya existen registros
    final existing = await dao.getAllTypes();
    if (existing.isNotEmpty) return; // ya está poblada

    // Insertar Droguería / Naturistas
    await dao.insertType(TypeInventoriesCompanion.insert(
      id: const Value(1),
      nombrees: 'Droguería / Naturistas',
      nombreen: 'Drugstore / Naturists',
      pathimage: 'assets/images/drogueria_naturista.png',
      descripcion: const Value('Inventario de medicamentos y productos naturistas'),
    ));

    // Insertar Servicios (Peluquería)
    await dao.insertType(TypeInventoriesCompanion.insert(
      id: const Value(2),
      nombrees: 'Servicios / Peluquería',
      nombreen: 'Services / Hairdressing',
      pathimage: 'assets/images/servicios_peluqueria.png',
      descripcion: const Value('Inventario de servicios de peluquería y estética'),
    ));

    // Insertar Productores / Apiario
    await dao.insertType(TypeInventoriesCompanion.insert(
      id: const Value(3),
      nombrees: 'Productores / Apiario',
      nombreen: 'Producers / Apiary',
      pathimage: 'assets/images/productores_apiario.png',
      descripcion: const Value('Inventario de colmenas y producción de miel'),
    ));

    // Insertar Ferretería
    await dao.insertType(TypeInventoriesCompanion.insert(
      id: const Value(4),
      nombrees: 'Ferretería',
      nombreen: 'Hardware Store',
      pathimage: 'assets/images/ferreteria.png',
      descripcion: const Value('Inventario de herramientas y materiales de construcción'),
    ));
  }
}
