import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import '/data/database/local/third_parts.dart';

class ClientDetailScreen extends StatelessWidget {
  final ThirdPartEntity entity;
  const ClientDetailScreen({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(entity.name),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Info"),
              Tab(text: "Historial"),
              Tab(text: "Notas"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildInfoTab(),
            _buildHistoryTab(),
            _buildNotesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Email: ${entity.email ?? ''}"),
        Text("Teléfono: ${entity.phone ?? ''}"),
        Text("Tipo: ${entity.thirdPartType ?? ''}"),
        Text("Dirección: ${entity.address ?? ''}"),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return const Center(child: Text("Historial de ventas/compras"));
  }

  Widget _buildNotesTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(entity.notes ?? "Sin notas"),
    );
  }
}
