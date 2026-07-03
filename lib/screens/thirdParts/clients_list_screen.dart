import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:stockmaster/providers/image_stockmaster_provider.dart';
import 'package:stockmaster/screens/thirdParts/client_list_item.dart';
import '/providers/third_parts_providers.dart';
import 'client_detail_screen.dart';
import 'client_form_screen.dart';
import '/data/database/local/third_part_mapper.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';

class ClientsListScreen extends ConsumerStatefulWidget {
  const ClientsListScreen({super.key});

  @override
  ConsumerState<ClientsListScreen> createState() => _ClientsListScreenState();
}

class _ClientsListScreenState extends ConsumerState<ClientsListScreen> {
  bool _loadingImage = false;

  @override
  Widget build(BuildContext context) {
    final entities = ref.watch(thirdPartsNotifierProvider);
    final clients = entities.map((e) => e.toModel()).toList();

    // ✅ obtenemos el ServicesDao desde el provider global
    final servicesDao = provider.Provider.of<ServicesDao>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Terceros")),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (_, i) {
          final c = clients[i];
          return ClientListItem(
            client: c,
            loadingImage: _loadingImage,
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ClientFormScreen(entity: c.toEntity())),
              );
            },
            onDelete: () {
              ref.read(thirdPartsNotifierProvider.notifier).deleteThirdPart(c.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${c.name} eliminado')),
              );
            },
            onTapDetail: () {
              final clienteSeleccionado = c.toEntity();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientDetailScreen(
                    entity: clienteSeleccionado,
                    servicesDao: servicesDao, // ✅ pasamos el DAO requerido
                  ),
                ),
              );
            },
            onImageSelected: (path) async {
              await ref.read(thirdPartsNotifierProvider.notifier)
                  .updateThirdPartImage(c.id, path);
              await ref.read(imageStockmasterProvider.notifier)
                  .upsertImageForClient(c.id, path);
            },
            onLoadingChanged: (loading) {
              setState(() => _loadingImage = loading);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ClientFormScreen()),
          );
        },
      ),
    );
  }
}
