import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '/helpers/uuid_helper.dart';

@DataClassName('ImageStockmasterEntity')
class ImagesStockmaster extends Table {
  // Identificador único de la imagen
  TextColumn get id => text().clientDefault(generateUuid)(); // 👈 usa la función

  // Ruta local o URL de la imagen
  TextColumn get path => text()();

  // Tipo de entidad a la que pertenece (ej: 'product', 'client')
  TextColumn get ownerType => text()();

  // Llave foránea: id del producto o cliente
  TextColumn get ownerId => text()();

  // Campo opcional para miniatura
  TextColumn get thumbnailPath => text().nullable()();

  // Fecha de creación
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();

  // Fecha de creación
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();


  @override
  Set<Column> get primaryKey => {id};
}
