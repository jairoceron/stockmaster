import 'package:drift/drift.dart';
import '../../constants/app_constants.dart';
import '../database/local/app_database.dart';
import '../database/local/product_dao.dart';
import 'package:uuid/uuid.dart';

class DatabaseInitializer {
  final ProductDao dao;
  final uuid = Uuid();

  DatabaseInitializer(this.dao);

  Future<void> initializeIfNeeded() async {
    final exists = await dao.hasAnyProducts();
    final dataInitial = await dao.insertInitialProducts([
      ProductsCompanion.insert(
          id:Value(uuid.v4()), // 👈 ahora correcto
          idbusiness: Value(uuid.v4()),
          idcategory: Value(uuid.v4()),
          name: Value("Cepillo Colgate"),
          image: Value("colgate1.png"),
          stock: Value(100),
          price: Value(52000.0),
          createdat: Value(DateTime.now()),
          owner: Value(''),
          barcode: Value(''),
          stockminimumlevel: Value(10),
          deviceid: Value(''),
          platform: Value('android',)),

      ProductsCompanion.insert(
          id:Value(uuid.v4()), // 👈 ahora correcto
          idbusiness: Value(uuid.v4()),
          idcategory: Value(uuid.v4()),
          name: Value("Cepillo Colgate"),
          image: Value("colgate1.png"),
          stock: Value(100),
          price: Value(52000.0),
          createdat: Value(DateTime.now()),
          owner: Value(''),
          barcode: Value(''),
          stockminimumlevel: Value(10),
          deviceid: Value(''),
          platform: Value('android',))
    ]);


    if (!exists) {
      // Tabla no existe → carga inicial
      dataInitial;
    } else {
      // Tabla existe → verificar si tiene registros
      final count = await dao.countProducts();
      if (count == 0) {
        // Si está vacía, también carga inicial

          dataInitial;

      }
    }
  }
}
