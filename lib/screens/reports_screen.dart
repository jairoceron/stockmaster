import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El AppBar y BottomNavigationBar ya vienen del RootScreen
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado interno
            const Text(
              "Reportes",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Tarjeta resumen de KPIs
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _ReportKpi(title: "Ventas Hoy", value: "\$1,250"),
                    _ReportKpi(title: "Clientes", value: "32"),
                    _ReportKpi(title: "Inventario", value: "540"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Lista de reportes disponibles
            Expanded(
              child: ListView(
                children: [
                  _ReportCard(
                    icon: Icons.bar_chart,
                    title: "Reporte de Ventas",
                    subtitle: "Resumen de ingresos y tendencias",
                    onTap: () {
                      // Navegar a detalle de reporte de ventas
                    },
                  ),
                  _ReportCard(
                    icon: Icons.people,
                    title: "Reporte de Clientes",
                    subtitle: "Actividad y crecimiento de clientes",
                    onTap: () {
                      // Navegar a detalle de reporte de clientes
                    },
                  ),
                  _ReportCard(
                    icon: Icons.inventory,
                    title: "Reporte de Inventario",
                    subtitle: "Stock actual y rotación",
                    onTap: () {
                      // Navegar a detalle de reporte de inventario
                    },
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

// Widget para KPIs
class _ReportKpi extends StatelessWidget {
  final String title;
  final String value;

  const _ReportKpi({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            )),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}

// Widget para tarjetas de reportes
class _ReportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ReportCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
