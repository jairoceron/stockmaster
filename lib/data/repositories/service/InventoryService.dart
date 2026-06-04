import 'package:drift/drift.dart';

import '../../../models/cart_item.dart';
import '../../database/local/app_database.dart';


class InventoryService {
  final AppDatabase db;

  InventoryService(this.db);

  /// Procesar un carrito: disminuir stock y registrar transacciones
  Future<void> processCartGroup(int cartGroupId, String userId, List<CartItem> cartItems) async {
    await db.transaction(() async {
      print("➡️ Iniciando transacción para carrito $cartGroupId con ${cartItems.length} items");
      for (final item in cartItems) {
        final String productId = item.product.id!; // UUID como String
        final quantity = item.quantity;
        final unitPrice = item.product.price;

        final product = await (db.select(db.products)
          ..where((p) => p.id.equals(productId)))
            .getSingle();

        final newStock = (product.stock ?? 0) - quantity;

        await (db.update(db.products)..where((p) => p.id.equals(productId)))
            .write(ProductsCompanion(
          stock: Value(newStock),
          lastsyncedat: Value(DateTime.now()),
          syncstate: const Value('pending'),
        ));

        await db.into(db.transactions).insert(TransactionsCompanion.insert(
          productId: productId, // String
          cartGroupId: cartGroupId,
          transactionType: 'sale',
          quantity: quantity,
          unitPrice: Value(unitPrice),
          totalAmount: Value(unitPrice * quantity),
          concept: Value('Venta desde carrito $cartGroupId'),
          userId: Value(int.tryParse(userId)), // ✅ conversión segura
          platform: const Value('mobile'),
          createdAt: Value(DateTime.now()),
          syncStatus: const Value(false),
          syncState: const Value('pending'),
        ));
      }


      // 3️⃣ Marcar carrito como procesado
      await (db.update(db.cartGroups)..where((c) => c.id.equals(cartGroupId)))
          .write(const CartGroupsCompanion(processed: Value(true)));
      print("✅ Carrito $cartGroupId marcado como procesado");

    });
    print("✔️ Transacción COMMIT realizada para carrito $cartGroupId");
  }


  /// Este método debería obtener los items del carrito desde tu CartNotifier
  Future<List<CartItem>> _getCartItems(int cartGroupId) async {
    // Aquí conectas con tu capa de estado (CartNotifier) o tabla intermedia
    // Por simplicidad, supongamos que CartNotifier expone itemsForGroup
    throw UnimplementedError("Conectar con CartNotifier.itemsForGroup");
  }
}
