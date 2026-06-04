import 'package:drift/drift.dart';
import 'app_database.dart';        // contiene TransactionEntity generado
import 'transactions.dart';       // definición de la tabla
import '../../../models/transaction.dart'; // tu modelo de dominio Transaction

import 'package:drift/drift.dart';
import 'app_database.dart';        // contiene TransactionEntity y TransactionsCompanion
import 'transactions.dart';       // definición de la tabla
import '../../../models/transaction.dart'; // tu modelo de dominio Transaction

class TransactionMapper {
  // 🔹 De entidad Drift (TransactionEntity) a modelo de dominio (Transaction)
  static Transaction fromEntity(TransactionEntity entity) {
    return Transaction(
      id: entity.id,
      productId: entity.productId,
      cartGroupId: entity.cartGroupId,
      transactionType: entity.transactionType,
      quantity: entity.quantity,
      unitPrice: entity.unitPrice ?? 0.0,
      totalAmount: entity.totalAmount ?? 0.0,
      concept: entity.concept,
      userId: entity.userId,
      platform: entity.platform,
      createdAt: entity.createdAt,
      syncStatus: entity.syncStatus,
      lastSyncedAt: entity.lastSyncedAt,
      syncState: entity.syncState,
    );
  }

  // 🔹 De modelo de dominio (Transaction) a Companion para INSERT
  static TransactionsCompanion toInsertCompanion(Transaction tx) {
    return TransactionsCompanion.insert(
      productId: tx.productId,
      cartGroupId: tx.cartGroupId, // 👈 obligatorio
      transactionType: tx.transactionType,
      quantity: tx.quantity,
      unitPrice: Value(tx.unitPrice),
      totalAmount: Value(tx.totalAmount),
      concept: Value(tx.concept),
      userId: Value(tx.userId),
      platform: Value(tx.platform),
      createdAt: Value(tx.createdAt),
      syncStatus: Value(tx.syncStatus ?? false),
      syncState: Value(tx.syncState ?? 'pending'),
      lastSyncedAt: Value(tx.lastSyncedAt),
    );
  }

  // 🔹 De modelo de dominio (Transaction) a Companion para UPDATE
  static TransactionsCompanion toUpdateCompanion(Transaction tx) {
    return TransactionsCompanion(
      id: Value(tx.id!), // 👈 obligatorio para update
      productId: Value(tx.productId),
      cartGroupId: Value(tx.cartGroupId),
      transactionType: Value(tx.transactionType),
      quantity: Value(tx.quantity),
      unitPrice: Value(tx.unitPrice),
      totalAmount: Value(tx.totalAmount),
      concept: Value(tx.concept),
      userId: Value(tx.userId),
      platform: Value(tx.platform),
      createdAt: Value(tx.createdAt),
      syncStatus: Value(tx.syncStatus ?? false),
      syncState: Value(tx.syncState ?? 'pending'),
      lastSyncedAt: Value(tx.lastSyncedAt),
    );
  }
}
