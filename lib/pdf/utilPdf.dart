import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/product.dart';
import '../models/transaction.dart';


// products: lista de mapas con {id, name, quantity}
// transactions: lista de objetos Transaction asociados
Future<void> generateAndShareInventoryReport(
    List<Map<String, dynamic>> products, List<Transaction> transactions) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Inventory Report",
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),

            // Tabla de productos
            pw.Table.fromTextArray(
              headers: [
                "ID",
                "Product",
                "Quantity",
                "Transaction Type",
                "Amount",
                "Note",
                "User"
              ],
              data: List<List<String>>.generate(products.length, (index) {
                final product = products[index] as Product;
                final transaction = transactions[index] as Transaction;
                return [
                  product.id?.toString() ?? "",
                  product.name?.toString() ?? "",
                  transaction.transactionType,
                  transaction.quantity.toString(), // 👈 usa quantity en vez de amount
                  transaction.concept ?? "",
                  transaction.userId?.toString() ?? "",
                ];
              }),

            ),
          ],
        );
      },
    ),
  );

  // Guardar PDF en directorio temporal
  final output = await pdf.save();
  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/inventory_report.pdf");
  await file.writeAsBytes(output);

  // Compartir vía WhatsApp (o cualquier app disponible)
  await Share.shareXFiles(
    [XFile(file.path)],
    text: 'Inventory report',
  );

}