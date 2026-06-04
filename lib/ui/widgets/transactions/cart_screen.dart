import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../state/cart_notifier.dart';
import '../../../providers/user_provider.dart'; // 👈 para obtener el userId

class CartScreen extends StatelessWidget {
  final int groupId; // 👈 identificador del carrito

  const CartScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carrito $groupId")),
      body: Consumer<CartNotifier>(
        builder: (context, cart, _) {
          final items = cart.itemsForGroup(groupId);

          if (items.isEmpty) {
            return const Center(child: Text("Este carrito está vacío"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(item.product.name ?? 'Sin nombre'),
                        subtitle: Text(
                          "Precio: \$${item.product.price} x ${item.quantity} = \$${(item.product.price * item.quantity).toStringAsFixed(2)}",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => cart.decreaseQuantity(groupId, item.product),
                            ),
                            Text("${item.quantity}"),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => cart.increaseQuantity(groupId, item.product),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => cart.removeProduct(groupId, item.product),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: \$${cart.totalAmountForGroup(groupId).toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print("🟢 Botón Finalizar compra presionado");

                        // Obtener el userId desde el UserProvider
                        final userId = context.read<UserProvider>().user.tenantid;

                        // Llamar al método de persistencia en el CartNotifier
                        await cart.processCartGroup(groupId, userId);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Compra finalizada")),
                        );
                      },
                      child: const Text("Finalizar compra"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
