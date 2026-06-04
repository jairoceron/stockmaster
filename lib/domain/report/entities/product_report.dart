import 'package:http/http.dart' as http;
import 'dart:convert';

/// Entidades del dominio
class ProductReport {
  final String productId;
  final String name;
  final int quantity;
  final double revenue;

  ProductReport({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.revenue,
  });

  factory ProductReport.fromJson(Map<String, dynamic> json) {
    return ProductReport(
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      revenue: json['revenue'].toDouble(),
    );
  }
}