// quick_sale_form_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart' as provider;
import 'package:drift/drift.dart' as drift;
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/sales.dart';
import 'package:stockmaster/data/database/local/sales_dao.dart';
import 'package:stockmaster/screens/sale/sale_actions.dart';
import 'package:stockmaster/screens/sale/sale_form_header.dart';
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
  final List<String> paymentMethods = ['Efectivo', 'Tarjeta', 'Nequi'];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _saveSale(Map<String, dynamic> data) async {
    final salesDao = provider.Provider.of<SalesDao>(context, listen: false);
    final selectedClient = ref.read(selectedClientProvider);

    final sale = SalesCompanion(
      id: drift.Value(generateUuid()),
      clientId: drift.Value(selectedClient?.id ?? ''),
      paymentMethod: drift.Value(data['metodo_pago']),
      totalAmount: drift.Value(double.parse(data['total'])),
      date: drift.Value(DateTime.now()),
    );

    await salesDao.insertSale(sale);

    final salesNotifier =
    provider.Provider.of<SalesNotifier>(context, listen: false);
    await salesNotifier.addSaleRecord({
      'date': DateTime.now(),
      'serviceName': 'Venta rápida',
      'price': double.parse(data['total']),
      'saleId': sale.id.value,
    });

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

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedClient = ref.watch(selectedClientProvider);

    return Scaffold(
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
              SaleFormHeader(paymentMethods: paymentMethods),
              const SizedBox(height: 12),
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
    );
  }
}
