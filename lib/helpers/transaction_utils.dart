// transaction_utils.dart
class TransactionUtils {
  /// Ajusta la cantidad según el tipo de transacción.
  /// Si es "output", devuelve la cantidad multiplicada por -1.
  static int adjustQuantity(String transactionType, int quantity) {
    if (transactionType == "output") {
      return quantity * -1;
    }
    return quantity;
  }
}