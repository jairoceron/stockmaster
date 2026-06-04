import 'dart:convert';
import 'package:http/http.dart' as http;
import '/domain/report/entities/inventory_summary_report.dart';
import '/domain/report/entities/inventory_list_report.dart';
import '/domain/report/entities/top_products_report.dart';
import '/domain/report/entities/stock_alert_report.dart';
import '/domain/report/entities/evolution_report.dart';
import '/domain/report/entities/price_stats_report.dart';
import '/domain/report/repositories/report_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final String baseUrl;

  ReportRepositoryImpl({required this.baseUrl});

  @override
  Future<InventorySummaryReport> getSummary(int idBusiness) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/summary?idbusiness=$idBusiness'));
    if (response.statusCode == 200) {
      return InventorySummaryReport.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener resumen');
    }
  }

  @override
  Future<List<InventoryListReport>> getInventoryList(int idBusiness) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/list?idbusiness=$idBusiness'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => InventoryListReport.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener listado');
    }
  }

  @override
  Future<List<TopProductsReport>> getTopProducts(int idBusiness, {int limit = 5}) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/top-products?idbusiness=$idBusiness&limit=$limit'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TopProductsReport.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener top productos');
    }
  }

  @override
  Future<List<StockAlertReport>> getStockAlerts(int idBusiness) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/stock-alerts?idbusiness=$idBusiness'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => StockAlertReport.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener alertas');
    }
  }

  @override
  Future<List<EvolutionReport>> getEvolution(int idBusiness) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/evolution?idbusiness=$idBusiness'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => EvolutionReport.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener evolución');
    }
  }

  @override
  Future<PriceStatsReport> getPriceStats(int idBusiness) async {
    final response = await http.get(Uri.parse('$baseUrl/reports/price-stats?idbusiness=$idBusiness'));
    if (response.statusCode == 200) {
      return PriceStatsReport.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener estadísticas de precios');
    }
  }
}
