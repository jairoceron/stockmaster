import '../../../models/transaction.dart'; // tu modelo de dominio
import '../../database/local/transaction_mapper.dart';
import '../../database/local/transaction_dao.dart'; // DAO

class SQLiteTransactionService {
  final TransactionDao dao;

  SQLiteTransactionService(this.dao);

  // Recibe tu modelo de dominio Transaction
// Recibe tu modelo de dominio Transaction
  Future<Transaction> addTransaction(Transaction tx) async {
    // Convertir a Companion para insertarlo
    final companion = TransactionMapper.toInsertCompanion(tx);
    final id = await dao.insertTransaction(companion);

    // Leer el registro insertado desde Drift
    final row = await dao.getTransactionById(id);

    // Convertir de entidad Drift a modelo de dominio
    return TransactionMapper.fromEntity(row!);
  }


  Future<List<Transaction>> getTransactions() async {
    final rows = await dao.getAllTransactions();
    return rows.map(TransactionMapper.fromEntity).toList();
  }

  Future<void> deleteTransaction(int id) async {
    await dao.deleteTransaction(id);
  }

  

}
