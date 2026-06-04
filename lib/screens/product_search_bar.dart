import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const ProductSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Buscar producto...',
      ),
      onChanged: onSearch,
    );
  }
}
