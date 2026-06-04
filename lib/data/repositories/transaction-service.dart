import '../database/local/transaction_dao.dart';

class TransactionService {
  final TransactionDao dao;
  TransactionService(this.dao);

  Future<double> getTodaySalesReport() async {
    return await dao.getTodaySalesTotal();
  }
}