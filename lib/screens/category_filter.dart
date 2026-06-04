import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final ValueChanged<String?> onCategorySelected;

  const CategoryFilter({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: categories.map((category) {
        return ChoiceChip(
          label: Text(category),
          selectedColor: Theme.of(context).colorScheme.primary,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          selected: false,
          onSelected: (_) => onCategorySelected(category),
        );
      }).toList(),
    );
  }
}
