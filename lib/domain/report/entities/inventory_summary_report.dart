class InventorySummaryReport {
  final int totalProductos;
  final int? stockTotal;
  final double? valorTotal;

  InventorySummaryReport({
    required this.totalProductos,
    this.stockTotal,
    this.valorTotal,
  });

  factory InventorySummaryReport.fromJson(Map<String, dynamic> json) {
    return InventorySummaryReport(
      totalProductos: json['totalProductos'] ?? 0,
      stockTotal: json['stockTotal'] as int?, // puede ser null
      valorTotal: (json['valorTotal'] as num?)?.toDouble(), // puede ser null
    );
  }
}
