class TopProductsReport {
  final String name;
  final double valorInventario;

  TopProductsReport({required this.name, required this.valorInventario});

  factory TopProductsReport.fromJson(Map<String, dynamic> json) {
    return TopProductsReport(
      name: json['name'],
      valorInventario: (json['valor_inventario'] as num).toDouble(),
    );
  }
}
