class InventoryListReport {
  final String productId;
  final String name;
  final int quantity;
  final double revenue;

  InventoryListReport({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.revenue,
  });

  factory InventoryListReport.fromJson(Map<String, dynamic> json) {
    return InventoryListReport(
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      revenue: (json['revenue'] as num).toDouble(),
    );
  }
}
