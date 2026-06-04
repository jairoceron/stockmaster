import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/transaction.dart';
import '../../../state/transaction_notifier.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  @override
  void initState() {
    super.initState();
    // 🔹 cargar transacciones una sola vez al iniciar
    Future.microtask(() =>
        Provider.of<TransactionNotifier>(context, listen: false).loadTransactions());
  }

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TransactionNotifier>(context);
    final transactions = notifier.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transacciones"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await notifier.refreshAfterPurchase();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Transacciones actualizadas")),
              );
            },
          ),
        ],
      ),
      body: transactions.isEmpty
          ? const Center(child: Text("No hay transacciones"))
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.swap_horiz),
              title: Text(
                "${tx.transactionType} - Cantidad: ${tx.quantity}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Producto: ID:${tx.productId} ${tx.concept ?? ''}"),
                  Text("Carrito ID: ${tx.cartGroupId}"),
                  Text("Total: \$${tx.totalAmount?.toStringAsFixed(2) ?? '0.00'}"),
                  Text("Fecha: ${tx.createdAt}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await notifier.deleteTransaction(tx.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Transacción ${tx.id} eliminada")),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
