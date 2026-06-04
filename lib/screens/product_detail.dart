import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '/constants/app_constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '/pdf/generateDetail.pdf.dart';

// Servicio para invocar la API
Future<Map<String, dynamic>> fetchProductDetail(int idProducto) async {
  final url = Uri.parse(AppConstants.queryMiel05);

  print("Invocando API detalle con idProducto: $idProducto");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"id": idProducto}),
  );

  print("Status code: ${response.statusCode}");
  print("Respuesta cruda: ${response.body}");

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    print("Data decodificada: $data");
    return data;
  } else {
    throw Exception("Error ${response.statusCode}: ${response.body}");
  }
}

// Pantalla de detalle
class ProductDetailScreen extends StatelessWidget {
  final int idProducto;

  const ProductDetailScreen({super.key, required this.idProducto});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchProductDetail(idProducto),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error: ${snapshot.error}")),
          );
        }

        final product = snapshot.data?["product"] ?? {};
        final List transactions = snapshot.data?["transactions"] ?? [];

        return Scaffold(
          appBar: AppBar(
            title: const Text("Product Details"),
            actions: [
              IconButton(
                icon: const Icon(Icons.picture_as_pdf),
                tooltip: "Export to PDF",
                onPressed: () {
                  generateProductPdf(product, transactions);
                  print("PDF icon pressed");
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "ID: ${product["id"]?.toString() ?? "N/A"} - Product: ${product["name"]?.toString() ?? "Unnamed"}",
                    ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Price: ",
                              style: const TextStyle(
                                fontSize: 14, // tamaño más pequeño
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: product["price"] != null
                                  ? NumberFormat.currency(
                                symbol: "\$",
                                decimalDigits: 0,
                              ).format(product["price"])
                                  : "\$0",
                              style: const TextStyle(
                                fontSize: 14, // 🔽 más pequeño
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: " - Stock: ${product["quantity"]?.toString() ?? "0"}",
                              style: const TextStyle(
                                fontSize: 14, // 🔽 más pequeño
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Transactions",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tx = transactions[index] ?? {};
                        return ListTile(
                          leading: Icon(
                            (tx["tipotransaccion"] ?? "") == "input"
                                ? Icons.add_circle
                                : Icons.remove_circle,
                            color: (tx["tipotransaccion"] ?? "") == "input"
                                ? Colors.green
                                : Colors.red,
                          ),
                          title: Text(
                            "${tx["concepto"] ?? "N/A"} - Qty: ${tx["quantity"] ?? 0}",
                          ),
                          subtitle: Text(
                            "Date: ${tx["created_at"] != null ? DateFormat('MM-dd HH:mm').format(DateTime.parse(tx["created_at"])) : ""}",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}