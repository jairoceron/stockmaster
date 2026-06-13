import 'package:drift/drift.dart';
import 'products.dart';
import 'app_database.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(AppDatabase db) : super(db);


  /// Actualizar producto completo
  Future<bool> updateProduct(ProductEntity entity) =>
      update(products).replace(entity);

  /// Eliminar todos los productos que sean demo
  Future<int> deleteDemoProducts() {
    return (delete(products)..where((tbl) => tbl.isdemo.equals(true))).go();
  }

  /// Actualizar solo la imagen de un producto
  Future<int> updateProductImage(String id, String imagePath) {
    return (update(products)..where((tbl) => tbl.id.equals(id)))
        .write(ProductsCompanion(image: Value(imagePath)));
  }


  /// Obtener todos los productos
  Future<List<ProductEntity>> getAll() => select(products).get();

  /// Insertar producto y devolver la entidad completa (con UUID)
  Future<ProductEntity> insertProductEntity(ProductsCompanion entry) =>
      into(products).insertReturning(entry);

  /// Insertar producto y devolver solo el id autoincrementado
  Future<int> insertProductId(ProductsCompanion entry) =>
      into(products).insert(entry);

  /// Obtener producto por id
  Future<ProductEntity?> getProductById(String id) =>
      (select(products)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();



  /// Eliminar producto por id
  Future<int> deleteProduct(String id) =>
      (delete(products)..where((tbl) => tbl.id.equals(id))).go();

  /// Verificar si hay productos
  Future<bool> hasAnyProducts() async {
    final count = await (select(products)..limit(1)).get();
    return count.isNotEmpty;
  }



  /// Insertar productos iniciales en batch
  Future<void> insertInitialProducts(List<ProductsCompanion> initial) async {
    await batch((batch) {
      batch.insertAll(products, initial);
    });
  }

  /// Sumar stock sin SQL manual
  Future<int> sumStock() async {
    final rows = await select(products).get();
    return rows.fold<int>(0, (acc, p) => acc + (p.stock ?? 0));
  }

  /// Calcular valor total del inventario sin SQL manual
  Future<double> sumValorInventario() async {
    final rows = await select(products).get();
    return rows.fold<double>(
      0.0,
          (acc, p) => acc + ((p.stock ?? 0) * (p.price ?? 0.0)),
    );
  }

  /// Obtener todos los productos (alias de getAll)
  Future<List<ProductEntity>> getAllProducts() => select(products).get();


  Future<int> countProductsEfficient() async {
    final countExp = products.id.count();
    final query = selectOnly(products)..addColumns([countExp]);
    final result = await query.getSingle();
    return result?.read(countExp) ?? 0;
  }

  /// Contar productos
  Future<int> countProducts() async {
    final rows = await select(products).get();
    return rows.length;
  }

  Future<int> deleteAllProducts() {
    return delete(products).go();
  }

}
