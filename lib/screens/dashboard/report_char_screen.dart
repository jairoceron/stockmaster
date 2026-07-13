import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportCharScreen extends StatefulWidget {
  const ReportCharScreen({Key? key}) : super(key: key);

  @override
  State<ReportCharScreen> createState() => _ReportCharScreenState();
}

class _ReportCharScreenState extends State<ReportCharScreen> {
  final Random _random = Random();
  final List<_SalesData> _data = [
    _SalesData(0, 175),
    _SalesData(1, 95),
    _SalesData(2, 130),
    _SalesData(3, 165),
    _SalesData(4, 110),
    _SalesData(5, 80),
  ];
  int _tick = 6;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startUpdating();
  }

  void _startUpdating() {
    // Simulación lenta: cada 1 segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _data.removeAt(0);
        _data.add(_SalesData(_tick, (_random.nextInt(120) + 60).toDouble()));
        _tick++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<FlSpot> _generateFlSpots() {
    return _data.map((d) => FlSpot(d.time.toDouble(), d.sales)).toList();
  }

  @override
  Widget build(BuildContext context) {
    double lastValue = _data.last.sales;

    return Scaffold(
      appBar: AppBar(title: const Text("Ventas en el tiempo")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gráfico con fl_chart
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  minY: 60,
                  maxY: 180,
                  minX: _data.first.time.toDouble(),
                  maxX: _data.last.time.toDouble() + 1,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) =>
                            Text("t${value.toInt()}",
                                style: const TextStyle(fontSize: 10)),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, interval: 30),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateFlSpots(),
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          if (index == 0) {
                            return FlDotCirclePainter(
                                radius: 4,
                                color: Colors.blueAccent,
                                strokeWidth: 0);
                          }
                          double prev = _data[index - 1].sales;
                          Color pointColor =
                          spot.y >= prev ? Colors.green : Colors.red;
                          return FlDotCirclePainter(
                              radius: 4, color: pointColor, strokeWidth: 0);
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.blueAccent.withOpacity(0.2),
                      ),
                    ),
                    // Flecha de avance (último punto + desplazamiento)
                    LineChartBarData(
                      spots: [
                        FlSpot(_data.last.time.toDouble(), lastValue),
                        FlSpot(_data.last.time.toDouble() + 0.3, lastValue)
                      ],
                      isCurved: false,
                      color: Colors.blue,
                      barWidth: 4,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Gráfico con Syncfusion
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  minimum: _data.first.time.toDouble(),
                  maximum: _data.last.time.toDouble() + 1,
                  interval: 1,
                  title: AxisTitle(text: 'Tiempo'),
                ),
                primaryYAxis: NumericAxis(minimum: 60, maximum: 180, interval: 30),
                series: <CartesianSeries<_SalesData, int>>[
                  LineSeries<_SalesData, int>(
                    dataSource: _data,
                    xValueMapper: (_SalesData sales, _) => sales.time,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    color: Colors.blueAccent,
                    markerSettings: const MarkerSettings(isVisible: true),
                    pointColorMapper: (sales, index) {
                      if (index == 0) return Colors.blueAccent;
                      double prev = _data[index - 1].sales;
                      return sales.sales >= prev ? Colors.green : Colors.red;
                    },
                  ),
                  // Flecha de avance en Syncfusion
                  LineSeries<_SalesData, int>(
                    dataSource: [
                      _SalesData(_data.last.time, lastValue),
                      _SalesData(_data.last.time + 1, lastValue),
                    ],
                    xValueMapper: (_SalesData sales, _) => sales.time,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    color: Colors.blue,
                    width: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SalesData {
  final int time;
  final double sales;
  _SalesData(this.time, this.sales);
}
