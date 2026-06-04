import '../../DTO/ReportSummaryDTO.dart';
import '../../database/local/product_dao.dart';

class ReportService {
  final ProductDao dao;

  ReportService(this.dao);

  Future<ReportSummaryDTO> calcularResumen() async {
    final totalProductos = await dao.countProducts() ;

    final stockTotal = await dao.sumStock();
    final valorTotal = await dao.sumValorInventario();

    return ReportSummaryDTO(
      totalProductos: totalProductos,
      stockTotal: stockTotal,
      valorTotal: valorTotal,
    );
  }
}
