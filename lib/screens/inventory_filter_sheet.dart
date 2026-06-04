
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/inventory_provider.dart';
import '../state/inventory_notifier.dart';
import 'price_range_filter.dart';
import 'stock_filter.dart';

class InventoryFilterSheet extends StatefulWidget {
  const InventoryFilterSheet({Key? key}) : super(key: key);

  @override
  State<InventoryFilterSheet> createState() => _InventoryFilterSheetState();
}

class _InventoryFilterSheetState extends State<InventoryFilterSheet> {
  bool _useAndLogic = true;
  double _minPrice = 20000;
  double _maxPrice = 120000;
  double _minStock = 5;

  void _applyFilters(BuildContext context) {
    final provider = context.read<InventoryNotifier>();
/*
    if (_useAndLogic) {
      provider.applyAdvancedFiltersAND(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        minStock: _minStock,
      );
    } else {
      provider.applyAdvancedFiltersOR(
        minPrice: _minPrice,
        maxPrice: _maxPrice,
        minStock: _minStock,
      );
    }
    Navigator.pop(context);

 */
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text("Usar lógica AND"),
              subtitle: const Text("Si está apagado, se usa OR"),
              value: _useAndLogic,
              onChanged: (val) {
                setState(() => _useAndLogic = val);
              },
            ),
            PriceRangeFilter(
              minPrice: _minPrice,
              maxPrice: _maxPrice,
              onChanged: (min, max) {
                setState(() {
                  _minPrice = min;
                  _maxPrice = max;
                });
              },
            ),
            const SizedBox(height: 8),
            StockFilter(
              minStock: _minStock,
              onChanged: (value) {
                setState(() {
                  _minStock = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _applyFilters(context),
              icon: const Icon(Icons.filter_alt),
              label: const Text('Aplicar filtros'),
            ),
          ],
        ),
      ),
    );
  }
}
