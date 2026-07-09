import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../models/third_part.dart';
import '/providers/third_parts_providers.dart';
import '/data/database/local/third_part_mapper.dart';

/// ✅ Provider global para almacenar el cliente seleccionado (objeto completo de dominio)
final selectedClientProvider = StateProvider<ThirdPart?>((ref) => null);

class SingleChoiceListClientScreen extends ConsumerStatefulWidget {
  const SingleChoiceListClientScreen({super.key});

  @override
  ConsumerState<SingleChoiceListClientScreen> createState() =>
      _SingleChoiceListClientScreenState();
}

class _SingleChoiceListClientScreenState
    extends ConsumerState<SingleChoiceListClientScreen> {
  String? _selectedClientId;

  @override
  Widget build(BuildContext context) {
    // ✅ Usamos el notifier que ya trae los clientes desde el DAO/Repository
    final entities = ref.watch(thirdPartsNotifierProvider);
    final clients = entities.map((e) => e.toModel()).toList(); // aquí ya son ThirdPart

    return Scaffold(
      appBar: AppBar(title: const Text("Seleccionar Cliente")),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (_, i) {
          final c = clients[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: RadioListTile<String>(
              value: c.id,
              groupValue: _selectedClientId,
              title: Text(c.name),
              subtitle: Text(c.email ?? ""),
              secondary: CircleAvatar(
                backgroundImage: c.imageUrl != null
                    ? AssetImage(c.imageUrl!)
                    : const AssetImage("assets/images/default_user.png"),
              ),
              onChanged: (val) {
                setState(() => _selectedClientId = val);
                // ✅ Guardamos el objeto de dominio directamente
                ref.read(selectedClientProvider.notifier).state = c;
                // ✅ Retornamos inmediatamente al flujo que llamó
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
