// sale_actions.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SaleActions extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Future<void> Function(Map<String, dynamic>) onSave;

  const SaleActions({
    super.key,
    required this.formKey,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => formKey.currentState?.reset(),
            child: const Text('Cancelar'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final data = formKey.currentState!.value;
                await onSave(data);
              }
            },
            child: const Text('Guardar'),
          ),
        ),
      ],
    );
  }
}
