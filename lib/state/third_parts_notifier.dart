import '../data/database/local/app_database.dart';
import '../data/database/local/third_parts_dao.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/providers/third_parts_providers.dart';
import 'package:flutter/foundation.dart'; // para debugPrint
import 'package:drift/drift.dart'; // para Value()


class ThirdPartsNotifier extends Notifier<List<ThirdPartEntity>> {
  late ThirdPartsDao dao;

  @override
  List<ThirdPartEntity> build() {
    dao = ref.read(thirdPartsDaoProvider);

    // 👇 dispara la carga inicial
    _init();
    return [];
  }

  Future<void> _init() async {
    final data = await dao.getAllThirdParts();
    state = data;
  }

  Future<void> loadThirdParts() async {
    final data = await dao.getAllThirdParts();
    state = data;
  }

  Future<void> addThirdPart(ThirdPartEntity entity) async {
    await dao.insertThirdPart(entity);
    await loadThirdParts();
  }

  Future<void> updateThirdPart(ThirdPartEntity entity) async {
    await dao.updateThirdPart(entity);
    await loadThirdParts();
  }

  Future<void> deleteThirdPart(String id) async {
    await dao.deleteThirdPart(id);
    await loadThirdParts();
  }

  // 🔹 Nuevo método para actualizar la imagen de un cliente/tercero
  Future<void> updateThirdPartImage(String id, String newPath) async {
    // Buscar el cliente por id
    final entity = await dao.getThirdPartById(id);
    if (entity != null) {
      // Crear copia con imageUrl actualizado
      final updatedEntity = entity.copyWith(imageUrl: Value(newPath));

      // Actualizar en BD
      await dao.updateThirdPart(updatedEntity);

      // Refrescar estado
      await loadThirdParts();
    } else {
      // Si no existe, opcionalmente crear uno nuevo
      debugPrint('No se encontró ThirdPart con id $id');
    }
  }
}
