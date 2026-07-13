import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../data/database/local/app_database.dart';
import '../../data/database/local/product_dao.dart';
import '../../data/database/local/sales_dao.dart';
import '../../data/database/local/sales.dart';
import '../../models/third_part.dart';
import '../../providers/sale_state_notifier.dart';
import '../../providers/sales_notifier.dart';
import '../../helpers/product_image_helper.dart';
import '../../helpers/uuid_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import '/screens/thirdParts/single_choice_list_client_screen.dart';

class SaleScreenGeneral extends StatefulWidget {
  const SaleScreenGeneral({super.key});

  @override
  State<SaleScreenGeneral> createState() => _SaleScreenStateGeneral();
}

class _SaleScreenStateGeneral extends State<SaleScreenGeneral> {
  List<ProductEntity> _allProducts = [];
  List<ProductEntity> _visibleProducts = [];
  final Map<String, ValueNotifier<int>> _quantities = {};
  final Map<String, ImageProvider?> _imageCache = {};
  double _total = 0.0;
  final TextEditingController _manualController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _manualOverride = false;
  bool _showSearchField = false; // ✅ control para mostrar/ocultar búsqueda
  int _pageSize = 20;
  int _currentMax = 20;

  final List<String> _paymentMethods = [
    'Efectivo',
    'Tarjeta',
    'Transferencia',
    'Nequi',
    'Daviplata',
  ];
  String _selectedPaymentMethod = 'Efectivo';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_applySearch);
  }

  Future<void> _loadProducts() async {
    final dao = Provider.of<ProductDao>(context, listen: false);
    final products = await dao.getAllProducts();
    setState(() {
      _allProducts = products;
      _visibleProducts = _allProducts.take(_pageSize).toList();
    });

    for (var p in products) {
      _quantities[p.id] = ValueNotifier<int>(0);
      _quantities[p.id]!.addListener(_recalculateTotal);
      _imageCache[p.id] = ProductImageHelper.resolve(p.image);
    }
  }

  void _applySearch() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _visibleProducts = _allProducts.take(_currentMax).toList();
      });
    } else {
      setState(() {
        _visibleProducts = _allProducts
            .where((p) => (p.name ?? '').toLowerCase().contains(query))
            .take(_currentMax)
            .toList();
      });
    }
  }

  void _recalculateTotal() {
    if (_manualOverride) return;
    double newTotal = 0.0;
    for (var p in _allProducts) {
      final qty = _quantities[p.id]?.value ?? 0;
      newTotal += (p.price ?? 0.0) * qty;
    }
    setState(() => _total = newTotal);
    _manualController.text = _total.toStringAsFixed(2);
  }

  void _setManualTotal(String val) {
    final parsed = double.tryParse(val.replaceAll(',', '.').trim());
    if (parsed != null) {
      setState(() {
        _manualOverride = true;
        _total = parsed;
      });
    } else {
      setState(() {
        _manualOverride = false;
      });
      _recalculateTotal();
    }
  }

  void _loadMore() {
    setState(() {
      _currentMax += _pageSize;
      _applySearch();
    });
  }

  Future<void> _saveSale() async {
    final salesDao = Provider.of<SalesDao>(context, listen: false);
    final productDao = Provider.of<ProductDao>(context, listen: false);

    final metodoPago = _selectedPaymentMethod;
    final total = _total;

    final container = riverpod.ProviderScope.containerOf(context);
    final client = container.read(selectedClientProvider);

    final sale = SalesCompanion(
      id: drift.Value(generateUuid()),
      clientId: client != null
          ? drift.Value(client.id)
          : const drift.Value('vinokurov 20260710'),
      paymentMethod: drift.Value(metodoPago),
      totalAmount: drift.Value(total),
      date: drift.Value(DateTime.now()),
    );

    await salesDao.insertSale(sale);

    // ✅ Construimos el arreglo de items seleccionados
    final saleItems = <Map<String, dynamic>>[];
    for (var p in _allProducts) {
      final qty = _quantities[p.id]?.value ?? 0;
      if (qty > 0) {
        saleItems.add({
          'product': p,
          'quantity': qty,
        });
      }
    }
    debugPrint("\n\n saleItems construidos: $saleItems \n\n");

    await productDao.decrementStockForSale(saleItems);

    await Provider.of<SalesNotifier>(context, listen: false).addSaleRecord({
      'date': DateTime.now(),
      'serviceName': 'Venta general',
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
  }


  @override
  Widget build(BuildContext context) {
    if (_allProducts.isEmpty) {
      return const Center(child: Text('No hay productos disponibles'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // ✅ Botón lupa que despliega el campo de búsqueda
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  setState(() => _showSearchField = !_showSearchField);
                },
              ),
              if (_showSearchField)
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar producto',
                      border: OutlineInputBorder(),
                      isDense: true, // reduce altura
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              // ✅ Método de pago
              Expanded(
                flex: 2,
                child: FormBuilderDropdown<String>(
                  name: 'metodo_pago',
                  initialValue: _selectedPaymentMethod,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  items: _paymentMethods
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedPaymentMethod = val);
                    }
                  },
                  validator: FormBuilderValidators.required(),
                ),
              ),
              const SizedBox(width: 8),
              // ✅ Total
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _manualController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Total',
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                  ),
                  onChanged: _setManualTotal,
                ),
              ),
            ],
          ),
        ),
        // ✅ resto del código sin cambios
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent &&
                  _visibleProducts.length < _allProducts.length) {
                _loadMore();
              }
              return false;
            },
            child: ListView.builder(
              itemCount: _visibleProducts.length,
              itemBuilder: (_, i) {
                final p = _visibleProducts[i];
                final imageProvider = _imageCache[p.id];
                final qtyNotifier = _quantities[p.id]!;

                return ValueListenableBuilder<int>(
                  valueListenable: qtyNotifier,
                  builder: (_, qty, __) {
                    final isSelected = qty > 0;
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: imageProvider != null
                                ? CircleAvatar(backgroundImage: imageProvider)
                                : const CircleAvatar(
                              child: Icon(Icons.inventory),
                            ),
                            title: Text(p.name ?? 'Sin nombre'),
                            subtitle: Text(
                              'Stock: ${(p.stock ?? 0) - qty} | '
                              'Precio: \$${p.price?.toStringAsFixed(2) ?? '0.00'}',
                            ),
                            trailing: Checkbox(
                              value: isSelected,
                              onChanged: (val) =>
                                  qtyNotifier.value = val! ? 1 : 0,
                            ),
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Cantidad:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          onPressed: qty > 1
                                              ? () =>
                                                    qtyNotifier.value = qty - 1
                                              : null,
                                        ),
                                        Text(
                                          qty.toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                          onPressed: () =>
                                              qtyNotifier.value = qty + 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Total calculado: \$${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Registrar Venta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: _saveSale,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
