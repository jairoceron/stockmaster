import 'package:flutter/material.dart';

class StockFilter extends StatelessWidget {
  final double minStock;
  final ValueChanged<double> onChanged;

  const StockFilter({
    Key? key,
    required this.minStock,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stock mínimo: ${minStock.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Slider(
          value: minStock,
          min: 0,
          max: 100, // ✅ rango completo
          divisions: 100,
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
