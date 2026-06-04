class StockAlertReport {
  final String name;
  final int stock;

  StockAlertReport({
    required this.name,
    required this.stock,
  });

  factory StockAlertReport.fromJson(Map<String, dynamic> json) {
    return StockAlertReport(
      name: json['name'],
      stock: json['stock'],
    );
  }
}
