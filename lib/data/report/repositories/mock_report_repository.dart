import '/domain/report/entities/inventory_summary_report.dart';
import '/domain/report/entities/inventory_list_report.dart';
import '/domain/report/entities/top_products_report.dart';
import '/domain/report/entities/stock_alert_report.dart';
import '/domain/report/entities/evolution_report.dart';
import '/domain/report/entities/price_stats_report.dart';
import '../../../domain/report/repositories/report_repository.dart';

class MockReportRepository implements ReportRepository {
  @override
  Future<InventorySummaryReport> getSummary(int idBusiness) async {
    return InventorySummaryReport(totalProductos: 0, stockTotal: 0, valorTotal: 0.0);
  }

  @override
  Future<List<InventoryListReport>> getInventoryList(int idBusiness) async => [];

  @override
  Future<List<TopProductsReport>> getTopProducts(int idBusiness, {int limit = 5}) async => [];

  @override
  Future<List<StockAlertReport>> getStockAlerts(int idBusiness) async => [];

  @override
  Future<List<EvolutionReport>> getEvolution(int idBusiness) async => [];

  @override
  Future<PriceStatsReport> getPriceStats(int idBusiness) async =>
      PriceStatsReport(minPrice: 0.0, maxPrice: 0.0, avgPrice: 0.0);
}
