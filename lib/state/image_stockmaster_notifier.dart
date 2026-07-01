import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/image_stockmaster_provider.dart';
import '/data/database/local/app_database.dart';
import '/models/image_stockmaster.dart';

class ImageStockmasterNotifier extends Notifier<List<ImageStockmaster>> {
  late final AppDatabase db;

  @override
  List<ImageStockmaster> build() {
    // Inicializamos la BD desde el provider
    db = ref.watch(appDatabaseProvider);

    // Estado inicial vacío
    _loadImages();
    return [];
  }

  Future<void> _loadImages() async {
    final entities = await db.imagesStockmasterDao.getAllImages();
    state = entities.map((e) => ImageStockmaster(
      id: e.id,
      path: e.path,
      ownerType: e.ownerType,
      ownerId: e.ownerId,
      thumbnailPath: e.thumbnailPath,
      createdAt: e.createdAt,
    )).toList();
  }

  Future<void> addImage(ImageStockmaster image) async {
    await db.imagesStockmasterDao.insertImage(image.toEntity());
    await _loadImages();
  }

  Future<void> updateImagePath(String id, String newPath) async {
    await db.imagesStockmasterDao.updateImagePath(id, newPath);
    await _loadImages();
  }
  Future<void> upsertImageForClient(String clientId, String path) async {
    await db.imagesStockmasterDao.upsertImage(clientId, 'client', path);
    await _loadImages();
  }


  Future<void> deleteImage(String id) async {
    await db.imagesStockmasterDao.deleteImage(id);
    await _loadImages();
  }
}

// Provider con Notifier
final imageStockmasterProvider =
NotifierProvider<ImageStockmasterNotifier, List<ImageStockmaster>>(
      () => ImageStockmasterNotifier(),
);
