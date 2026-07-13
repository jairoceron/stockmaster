// sale_form_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import '../../providers/sale_state_notifier.dart';

class SaleFormHeader extends StatefulWidget {
  final List<String> paymentMethods;
  const SaleFormHeader({super.key, required this.paymentMethods});

  @override
  State<SaleFormHeader> createState() => _SaleFormHeaderState();
}

class _SaleFormHeaderState extends State<SaleFormHeader> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final saleState = Provider.of<SaleStateNotifier>(context, listen: false);
    _controller = TextEditingController(text: saleState.total.toStringAsFixed(2));

    // 🔥 escuchar cambios en el notifier
    saleState.addListener(() {
      if (!saleState.manualOverride) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.text = saleState.total.toStringAsFixed(2);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SaleStateNotifier>(
      builder: (context, saleState, _) {
        return Column(
          children: [
            Row(
              children: [
                const Text('Total:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'total',
                    controller: _controller,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.min(0.01),
                    ]),
                    onChanged: (val) {
                      final parsed = double.tryParse(val?.trim() ?? '');
                      if (parsed != null) {
                        saleState.setManualTotal(parsed);
                      } else {
                        saleState.resetManualOverride();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('*Método de pago:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 12),
                Expanded(
                  child: FormBuilderDropdown<String>(
                    name: 'metodo_pago',
                    initialValue: 'Efectivo',
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    items: widget.paymentMethods
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
