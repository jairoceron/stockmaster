/// Excepción personalizada para indicar que un producto ya existe en la base de datos.
class DuplicateProductException implements Exception {
  final String? productId;
  final String? message;

  DuplicateProductException(this.productId, {this.message});

  @override
  String toString() {
    return message ?? "El producto con id '$productId' ya existe en el inventario.";
  }
}