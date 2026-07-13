import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/data/database/local/inventory_movements_dao.dart';

class DashboardInventarioScreen extends StatefulWidget {
  final ProductDao productDao;
  final InventoryMovementsDao inventoryMovementsDao;

  const DashboardInventarioScreen({
    super.key,
    required this.productDao,
    required this.inventoryMovementsDao,
  });

  @override
  State<DashboardInventarioScreen> createState() =>
      _DashboardInventarioScreenState();
}

class _DashboardInventarioScreenState extends State<DashboardInventarioScreen> {
  String? selectedProductId;
  List<ProductEntity> products = [];
  List<InventoryMovementEntity> movements = [];

  // 👇 ScrollController para el listado
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // liberar el controlador
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final list = await widget.productDao.getAllProducts();
    list.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    setState(() {
      products = list;
    });
  }

  Future<void> _loadMovements(String productId) async {
    // 🔹 Consultar movimientos ordenados por timestamp ascendente
    final list =
    await widget.inventoryMovementsDao.getMovementsByProduct(productId);
    list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    setState(() {
      movements = list;
      selectedProductId = productId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = GoogleFonts.poppins(
      textStyle: theme.textTheme.bodyMedium,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard Inventario',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown de productos
            DropdownButton<String>(
              isExpanded: true,
              hint: Text('Seleccione un producto', style: textStyle),
              value: selectedProductId,
              items: products.map((p) {
                return DropdownMenuItem<String>(
                  value: p.id,
                  child: Row(
                    children: [
                      if (p.image != null)
                        Image.asset(p.image!,
                            width: 32, height: 32, fit: BoxFit.cover),
                      const SizedBox(width: 8),
                      Text(p.name ?? '', style: textStyle),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _loadMovements(value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Tabla de movimientos con Scrollbar visible
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                thickness: 6,
                radius: const Radius.circular(8),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: movements.length,
                  itemBuilder: (context, index) {
                    final m = movements[index];
                    final isEntrada = m.movementType == 'entrada';
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              isEntrada
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: isEntrada ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${m.timestamp.toLocal()}',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                isEntrada ? 'Entrada' : 'Salida',
                                style: textStyle.copyWith(
                                  color: isEntrada ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Cant: ${m.quantity}',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Prev: ${m.previousStock}',
                                style: textStyle,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Nuevo: ${m.newStock}',
                                style: textStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Grilla de 2 columnas con gráficas
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: movements
                                .map((m) => FlSpot(
                                m.timestamp.millisecondsSinceEpoch
                                    .toDouble(),
                                m.newStock.toDouble()))
                                .toList(),
                            isCurved: true,
                            color: Colors.blue.shade900,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barGroups: movements.map((m) {
                          final isEntrada = m.movementType == 'entrada';
                          return BarChartGroupData(
                            x: m.timestamp.millisecondsSinceEpoch,
                            barRods: [
                              BarChartRodData(
                                toY: m.quantity.toDouble(),
                                color: isEntrada ? Colors.green : Colors.red,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Grilla de 4 columnas con KPIs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKpiCard('Stock inicial',
                    movements.isNotEmpty ? movements.first.previousStock : 0),
                _buildKpiCard(
                    'Entradas',
                    movements
                        .where((m) => m.movementType == 'entrada')
                        .fold<int>(0, (sum, m) => sum + m.quantity)),
                _buildKpiCard(
                    'Salidas',
                    movements
                        .where((m) => m.movementType == 'salida')
                        .fold<int>(0, (sum, m) => sum + m.quantity)),
                _buildKpiCard('Stock actual',
                    movements.isNotEmpty ? movements.last.newStock : 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, int value) {
    return Column(
      children: [
        Text(title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.black)),
        Text('$value',
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
      ],
    );
  }
}
