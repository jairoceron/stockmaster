import '/domain/report/entities/inventory_summary_report.dart';
import '/domain/report/entities/inventory_list_report.dart';
import '/domain/report/entities/top_products_report.dart';
import '/domain/report/entities/stock_alert_report.dart';
import '/domain/report/entities/evolution_report.dart';
import '/domain/report/entities/price_stats_report.dart';

abstract class ReportRepository {
  Future<InventorySummaryReport> getSummary(int idBusiness);
  Future<List<InventoryListReport>> getInventoryList(int idBusiness);
  Future<List<TopProductsReport>> getTopProducts(int idBusiness, {int limit = 5});
  Future<List<StockAlertReport>> getStockAlerts(int idBusiness);
  Future<List<EvolutionReport>> getEvolution(int idBusiness);
  Future<PriceStatsReport> getPriceStats(int idBusiness);
}
