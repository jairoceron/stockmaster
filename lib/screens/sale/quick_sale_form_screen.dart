import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart' as provider;
import 'package:drift/drift.dart' as drift;
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/sales.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/data/database/local/product_dao.dart';
import 'package:stockmaster/screens/sale/sale_actions.dart';
import '../../providers/sale_state_notifier.dart';
import '../../providers/sales_notifier.dart';
import '/helpers/uuid_helper.dart';
import '/providers/third_parts_providers.dart';
import '/data/database/local/third_parts.dart';

import 'client_selector_button.dart';
import 'items_tab_view.dart';

class QuickSaleFormScreen extends ConsumerStatefulWidget {
  const QuickSaleFormScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QuickSaleFormScreen> createState() =>
      _QuickSaleFormScreenState();
}

class _QuickSaleFormScreenState extends ConsumerState<QuickSaleFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> paymentMethods = ['Efectivo', 'Tarjeta', 'Nequi', 'Transferencia', 'Daviplata'];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _saveSale(Map<String, dynamic> data) async {
    final salesDao = provider.Provider.of<SalesDao>(context, listen: false);
    final productDao = provider.Provider.of<ProductDao>(context, listen: false);
    final selectedClient = ref.read(selectedClientProvider);

    // Validar campos obligatorios
    final metodoPago = data['metodo_pago'] ?? 'Efectivo';
    final totalStr = data['total'] ?? '0';
    final total = double.tryParse(totalStr) ?? 0.0;

    final sale = SalesCompanion(
      id: drift.Value(generateUuid()),
      clientId: drift.Value(selectedClient?.id ?? ''),
      paymentMethod: drift.Value(metodoPago),
      totalAmount: drift.Value(total),
      date: drift.Value(DateTime.now()),
    );

    await salesDao.insertSale(sale);

    // descontar stock según productos seleccionados
    final saleState = provider.Provider.of<SaleStateNotifier>(context, listen: false);
    await productDao.decrementStockForSale(saleState.getSelectedItems());

    final salesNotifier =
    provider.Provider.of<SalesNotifier>(context, listen: false);
    await salesNotifier.addSaleRecord({
      'date': DateTime.now(),
      'serviceName': 'Venta rápida',
      'price': total,
      'saleId': sale.id.value,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Venta registrada: \$${total.toStringAsFixed(2)} ($metodoPago)',
          style: const TextStyle(fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green.shade600,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedClient = ref.watch(selectedClientProvider);

    return provider.ChangeNotifierProvider(
      create: (_) => SaleStateNotifier(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registrar Venta Rápida'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Productos'),
              Tab(text: 'Servicios'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                // 🔥 Campo método de pago integrado aquí
                /*Row(
                  children: [
                    const Text('-Método de pago:', style: TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FormBuilderDropdown<String>(
                        name: 'metodo_pago',
                        initialValue: paymentMethods.first,
                        decoration: const InputDecoration(border: OutlineInputBorder()),
                        items: paymentMethods
                            .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                            .toList(),
                        validator: FormBuilderValidators.required(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),*/
                ClientSelectorButton(selectedClient: selectedClient),
                const SizedBox(height: 12),
                Expanded(
                  child: ItemsTabView(tabController: _tabController),
                ),
                const SizedBox(height: 12),
                SaleActions(
                  formKey: _formKey,
                  onSave: _saveSale,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
