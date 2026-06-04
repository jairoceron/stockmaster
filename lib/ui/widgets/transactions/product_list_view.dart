import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../models/product.dart';
import '../../../state/cart_notifier.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartNotifier>();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.inventory),
            title: Text(product.name ?? "product_no_name".tr()),
            subtitle: Text("${"product_price".tr()}: \$${product.price}"),
            trailing: ElevatedButton.icon(
              onPressed: () {
                cart.addProduct(product, quantity: 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "product_added".tr(namedArgs: {"product": product.name ?? ""}),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: Text("product_add_button".tr()),
            ),
          ),
        );
      },
    );
  }
}
