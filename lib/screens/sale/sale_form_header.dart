import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SaleFormHeader extends StatelessWidget {
  final List<String> paymentMethods;
  const SaleFormHeader({super.key, required this.paymentMethods});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Total:', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            Expanded(
              child: FormBuilderTextField(
                name: 'total',
                decoration: const InputDecoration(
                  hintText: '0.00',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(0.01),
                ]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Método de pago:',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(width: 12),
            Expanded(
              child: FormBuilderDropdown<String>(
                name: 'metodo_pago',
                initialValue: 'Efectivo',
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: paymentMethods
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
