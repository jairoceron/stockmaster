import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart' as provider;
import 'package:drift/drift.dart' as drift;
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/sales.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/sale_items_dao.dart';
import 'package:stockmaster/data/database/local/services_dao.dart';
import '../../providers/sales_notifier.dart';
import '/helpers/uuid_helper.dart';
import '/state/third_parts_notifier.dart';
import '/providers/third_parts_providers.dart';
import '/data/database/local/third_parts.dart';


class QuickSaleFormScreen extends StatefulWidget {
  const QuickSaleFormScreen({Key? key}) : super(key: key);

  @override
  State<QuickSaleFormScreen> createState() => _QuickSaleFormScreenState();
}

class _QuickSaleFormScreenState extends State<QuickSaleFormScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> paymentMethods = ['Efectivo', 'Tarjeta', 'Nequi'];

  /// Método helper para guardar la venta en la tabla sales y actualizar el notifier
  Future<void> _saveSale(Map<String, dynamic> data) async {
    final salesDao = provider.Provider.of<SalesDao>(context, listen: false);

    final sale = SalesCompanion(
      id: drift.Value(generateUuid()), // UUID único
      clientId: const drift.Value(''), // null/empty para venta rápida
      paymentMethod: drift.Value(data['metodo_pago']),
      totalAmount: drift.Value(double.parse(data['total'])),
      date: drift.Value(DateTime.now()),
    );

    await salesDao.insertSale(sale);

    // 🔹 Actualizamos el SalesNotifier si está disponible en el árbol de widgets
    final salesNotifier = provider.Provider.of<SalesNotifier>(context, listen: false);
    await salesNotifier.addSaleRecord({
      'date': DateTime.now(),
      'serviceName': 'Venta rápida',
      'price': double.parse(data['total']),
      'saleId': sale.id.value,
    });

    // Notificación moderna
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Venta registrada: \$${data['total']} (${data['metodo_pago']})',
          style: const TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
      ),
    );

    // 👇 Retornar a la pantalla que llamó después de un pequeño delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, true); // retornamos true para indicar éxito
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Venta Rápida'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total
              Row(
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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

              // Método de pago
              Row(
                children: [
                  const Text(
                    'Método de pago:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: 'metodo_pago',
                      initialValue: 'Efectivo',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: paymentMethods
                          .map((m) => DropdownMenuItem(
                        value: m,
                        child: Text(m),
                      ))
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Opciones avanzadas
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('+ Opciones Avanzadas'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 12),

              // Botones opcionales
              OutlinedButton(
                onPressed: () {},
                child: const Text('Cliente (Opcional)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Seleccionar Productos (Opcional)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Notas (Opcional)'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
              const Spacer(),

              // Botones inferiores
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _formKey.currentState?.reset(),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final data = _formKey.currentState!.value;
                          await _saveSale(data);
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
