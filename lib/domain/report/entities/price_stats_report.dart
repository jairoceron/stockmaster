class PriceStatsReport {
  final double minPrice;
  final double maxPrice;
  final double avgPrice;

  PriceStatsReport({
    required this.minPrice,
    required this.maxPrice,
    required this.avgPrice,
  });

  factory PriceStatsReport.fromJson(Map<String, dynamic> json) {
    return PriceStatsReport(
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPric'] as num).toDouble(),
      avgPrice: (json['avgPrice'] as num).toDouble(),
    );
  }
}
