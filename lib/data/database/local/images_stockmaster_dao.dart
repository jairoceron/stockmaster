import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:uuid/uuid.dart';
import 'package:stockmaster/data/database/local/images_stockmaster.dart';
part 'images_stockmaster_dao.g.dart';

@DriftAccessor(tables: [ImagesStockmaster])
class ImagesStockmasterDao extends DatabaseAccessor<AppDatabase>
    with _$ImagesStockmasterDaoMixin {
  ImagesStockmasterDao(AppDatabase db) : super(db);

  // Insertar nueva imagen
  Future<void> insertImage(ImageStockmasterEntity entity) =>
      into(imagesStockmaster).insert(entity);

  // Actualizar imagen existente (reemplaza toda la entidad)
  Future<bool> updateImage(ImageStockmasterEntity entity) =>
      update(imagesStockmaster).replace(entity);

  // 🔹 Actualizar solo el campo path por id
  Future<int> updateImagePath(String id, String newPath) {
    return (update(imagesStockmaster)..where((tbl) => tbl.id.equals(id))).write(
      ImagesStockmasterCompanion(
        path: Value(newPath),
        updatedAt: Value(
          DateTime.now(),
        ), // opcional: registrar fecha de actualización
      ),
    );
  }

  // Eliminar imagen por id
  Future<int> deleteImage(String id) =>
      (delete(imagesStockmaster)..where((tbl) => tbl.id.equals(id))).go();

  // Obtener todas las imágenes
  Future<List<ImageStockmasterEntity>> getAllImages() =>
      select(imagesStockmaster).get();

  // Obtener imágenes por tipo de dueño (ej: product, client)
  Future<List<ImageStockmasterEntity>> getImagesByOwner(
    String ownerType,
    String ownerId,
  ) {
    return (select(imagesStockmaster)..where(
          (tbl) =>
              tbl.ownerType.equals(ownerType) & tbl.ownerId.equals(ownerId),
        ))
        .get();
  }

  // Obtener una sola imagen por id
  Future<ImageStockmasterEntity?> getImageById(String id) {
    return (select(
      imagesStockmaster,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertImage(
    String ownerId,
    String ownerType,
    String path,
  ) async {
    final existing = await (select(
      imagesStockmaster,
    )..where((tbl) => tbl.ownerId.equals(ownerId))).getSingleOrNull();

    if (existing != null) {
      // Actualizar el path
      await (update(
        imagesStockmaster,
      )..where((tbl) => tbl.id.equals(existing.id))).write(
        ImagesStockmasterCompanion(
          path: Value(path),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      // Generar un id único para la imagen
      final newId = const Uuid().v4();

      final entity = ImagesStockmasterCompanion(
        id: Value(newId),
        path: Value(path),
        ownerType: Value(ownerType),
        ownerId: Value(ownerId),
        createdAt: Value(DateTime.now()),
      );
      await into(imagesStockmaster).insert(entity);
    }
  }
}
