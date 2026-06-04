import 'package:flutter/material.dart';

class PriceRangeFilter extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final Function(double, double) onChanged;

  const PriceRangeFilter({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Precio: \$${minPrice.toStringAsFixed(0)} - \$${maxPrice.toStringAsFixed(0)}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        RangeSlider(
          values: RangeValues(minPrice, maxPrice),
          min: 0,
          max: 600000, // ✅ rango completo
          divisions: 600, // cada paso = 1000 aprox
          activeColor: Theme.of(context).colorScheme.primary,
          onChanged: (values) => onChanged(values.start, values.end),
        ),
      ],
    );
  }
}
