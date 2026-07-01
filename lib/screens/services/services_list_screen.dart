import 'package:flutter/material.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/screens/services/service_card.dart';
import 'package:stockmaster/screens/services/service_form_screen.dart';

class ServicesListScreen extends StatefulWidget {
  final ServicesDao servicesDao;

  const ServicesListScreen({Key? key, required this.servicesDao})
      : super(key: key);

  @override
  State<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {
  late Future<List<ServiceEntity>> _servicesFuture;

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  void _loadServices() {
    _servicesFuture = widget.servicesDao.getAllServices();
  }

  Future<void> _deleteService(String id) async {
    await widget.servicesDao.deleteService(id);
    setState(() {
      _loadServices();
    });
  }

  Future<void> _updateServiceImage(ServiceEntity updatedService) async {
    await widget.servicesDao.updateServiceImage(updatedService.id, updatedService.image!);
    setState(() {
      _loadServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servicios"),
      ),
      body: FutureBuilder<List<ServiceEntity>>(
        future: _servicesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay servicios registrados"));
          }

          final services = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final service = services[index];
                    return ServiceCard(
                      service: service,
                      onDelete: (id) async => _deleteService(id),
                      onUpdateImage: (updatedService) async =>
                          _updateServiceImage(updatedService),
                    );
                  },
                  childCount: services.length,
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Ventas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reportes",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navegar a Ventas
          } else if (index == 1) {
            // Navegar a Reportes
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text("Agregar Servicio"),
        onPressed: () async {
          final newService = await Navigator.push<ServiceEntity>(
            context,
            MaterialPageRoute(builder: (_) => const ServiceFormScreen()),
          );

          if (newService != null) {
            setState(() {
              _servicesFuture = _servicesFuture.then((services) {
                return [newService, ...services];
              });
            });
          }
        },
      ),
    );
  }
}
