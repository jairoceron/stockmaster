class MonthlyReport {
  final String mes;
  final int productosCreados;

  MonthlyReport({required this.mes, required this.productosCreados});

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return MonthlyReport(
      mes: json['mes'],
      productosCreados: json['productos_creados'],
    );
  }
}
