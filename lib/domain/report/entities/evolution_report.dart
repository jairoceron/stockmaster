class EvolutionReport {
  final String mes;
  final int productosCreados;

  EvolutionReport({
    required this.mes,
    required this.productosCreados,
  });

  factory EvolutionReport.fromJson(Map<String, dynamic> json) {
    return EvolutionReport(
      mes: json['mes'],
      productosCreados: json['productos_creados'],
    );
  }
}
