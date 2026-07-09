// service_list_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import 'package:stockmaster/data/database/local/services.dart';
import '../../data/database/local/app_database.dart';
import '../../helpers/product_image_helper.dart';

class ServiceListView extends StatefulWidget {
  const ServiceListView({super.key});

  @override
  State<ServiceListView> createState() => _ServiceListViewState();
}

class _ServiceListViewState extends State<ServiceListView> {
  List<ServiceEntity> _services = [];

  @override
  void initState() {
    super.initState();
    _loadServices();
  }

  Future<void> _loadServices() async {
    final dao = Provider.of<ServicesDao>(context, listen: false);
    final services = await dao.getAllServices();
    setState(() => _services = services);
  }

  @override
  Widget build(BuildContext context) {
    if (_services.isEmpty) {
      return const Center(child: Text('No hay servicios disponibles'));
    }

    return ListView.builder(
      itemCount: _services.length,
      itemBuilder: (_, i) {
        final s = _services[i];
        final imageProvider = ProductImageHelper.resolve(s.image);

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: imageProvider != null
                ? CircleAvatar(backgroundImage: imageProvider)
                : const CircleAvatar(child: Icon(Icons.design_services)),
            title: Text(s.name ?? 'Sin nombre'),
            subtitle: Text(
              'Precio: \$${s.price?.toStringAsFixed(2) ?? '0.00'}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Aquí puedes manejar la selección del servicio
                // Por ejemplo, retornarlo al flujo de venta rápida
                Navigator.pop(context, s);
              },
            ),
          ),
        );
      },
    );
  }
}
