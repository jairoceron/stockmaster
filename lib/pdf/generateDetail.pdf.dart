import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generateProductPdf(Map<String, dynamic> product, List transactions) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Product Details", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 16),
            pw.Text("ID: ${product["id"] ?? "N/A"}"),
            pw.Text("Name: ${product["name"] ?? "Unnamed"}"),
            pw.Text("Price: \$${product["price"] ?? 0}"),
            pw.Text("Stock: ${product["quantity"] ?? 0}"),
            pw.SizedBox(height: 24),
            pw.Text("Transactions", style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return pw.Text(
                  "${tx["concepto"] ?? "N/A"} - Qty: ${tx["quantity"] ?? 0} - Date: ${tx["created_at"] ?? ""}",
                );
              },
            ),
          ],
        );
      },
    ),
  );

  // Mostrar el PDF en pantalla o compartirlo
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}