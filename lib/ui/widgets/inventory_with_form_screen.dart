import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockmaster/data/repositories/postgres_aws_product_repository.dart';
import 'package:stockmaster/ui/widgets/transactions/cart_screen.dart';
import 'package:stockmaster/ui/widgets/transactions/transaction_list_screen.dart';
import '../../services/GraphQL_Service.dart' show GraphQLService;
import '/models/cart_group.dart';
import '../../../factories/product_factory.dart';
import '../../../services/product_service.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../data/repositories/product_repository.dart';
import '../../state/cart_notifier.dart';
import '../../state/inventory_notifier.dart';
import 'product_list_view.dart';
import 'product_form.dart';
import 'package:uuid/uuid.dart';

class InventoryWithFormScreen extends StatefulWidget {
  const InventoryWithFormScreen({Key? key}) : super(key: key);

  @override
  State<InventoryWithFormScreen> createState() =>
      _InventoryWithFormScreenState();
}

class _InventoryWithFormScreenState extends State<InventoryWithFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _barcodeController.dispose(); // 👈 importante
    super.dispose();
  }

  Future<void> _saveProduct() async {
    final appUser = context.read<UserProvider>().user;
    final uuid = const Uuid().v4();

    if (_formKey.currentState!.validate()) {
      final now = DateTime.now().toUtc();
      final createdAt = now.toIso8601String();

      final tenantId = context.read<UserProvider>().user.tenantid;

      debugPrint("\n\n\n  tenantId >>>> $tenantId      \n\n\n");

      final product = await ProductFactory.fromForm(
        id: const Uuid().v4(),
        idbusiness: tenantId,
        name: _nameController.text,
        stock: _stockController.text,
        price: _priceController.text,
        barcode: _barcodeController.text, // 👈 guardamos el código de barras
        user: appUser,
      );

      debugPrint(
        "\n\n ........ inventory_with_form_screen.dart  I am in this class: ${runtimeType}  ${product} $product \n\n  ",
      );

      final service = ProductService(
        context.read<ProductRepository>(),
        context.read<InventoryNotifier>(),
      );

      await service.saveProduct(product);

      final session =
          await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
      if (session.isSignedIn) {
        /*****
         *     mutacion de agregar producto ....
         */
        final client = await GraphQLService().getClient();
        final repo = PostgresAWSProductRepository(client);
        repo.add(product);
        debugPrint(
          "\n\n\n aqui hacemos lo de la mutacion create product, que inserta registros en aws database2 postres !!!!   \n\n\n",
        );
        debugPrint(
          "\n\n\n solo para usuarios registrados, se debe garantizar la funcionalidad en la maquina local, lo otro viene por añadidura   \n\n\n",
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado correctamente')),
      );
    }
  }

  void _openForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: ProductForm(
                formKey: _formKey,
                nameController: _nameController,
                stockController: _stockController,
                priceController: _priceController,
                barcodeController: _barcodeController, // 👈 ahora sí
                onSaveAndAddAnother: () async {
                  await _saveProduct();
                  _nameController.clear();
                  _stockController.clear();
                  _priceController.clear();
                  _barcodeController.clear();
                  FocusScope.of(context).unfocus();
                },
                onSaveAndClose: () async {
                  await _saveProduct();
                  Navigator.of(context).pop();
                  FocusScope.of(context).unfocus();
                },
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = context.watch<InventoryNotifier>().products;

    return Scaffold(
      appBar: AppBar(title: const Text('Inventario + Agregar Producto')),
      body: Column(
        children: [
          // 👇 Lista de productos arrastrables
          Expanded(child: ProductListView(products: products)),

          // 👇 Múltiples carritos flotantes como DragTarget
          Consumer<CartNotifier>(
            builder: (context, cart, _) {
              final cartGroups = cart.activeGroups;

              if (cartGroups.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("No hay carritos activos"),
                );
              }

              return SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cartGroups.length,
                  itemBuilder: (context, index) {
                    final group = cartGroups[index];
                    final items = cart.itemsForGroup(group.id);

                    return DragTarget<Product>(
                      onAccept: (product) {
                        cart.addProductToGroup(group.id, product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.name} agregado a ${group.name}",
                            ),
                          ),
                        );
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: candidateData.isNotEmpty
                                ? Colors.green.withOpacity(0.2)
                                : Colors.blueGrey.withOpacity(0.1),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.shopping_cart),
                                title: Text(
                                  group.name ?? "Carrito ${group.id}",
                                ),
                              ),
                              Expanded(
                                child: items.isEmpty
                                    ? const Center(child: Text("Vacío"))
                                    : ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, i) {
                                          final item = items[i];
                                          return Text(
                                            "${item.product.name} x${item.quantity}",
                                          );
                                        },
                                      ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CartScreen(groupId: group.id),
                                    ),
                                  );
                                },
                                child: const Text("Ver carrito"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),

      // 👇 FABs en columna vertical
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "newCartFab",
            onPressed: () {
              final cart = context.read<CartNotifier>();

              final nuevoCarrito = CartGroup(
                id: DateTime.now().millisecondsSinceEpoch,
                name: "Carrito ${cart.activeGroups.length + 1}",
                createdAt: DateTime.now(),
              );

              cart.createCartGroup("Carrito ${cart.activeGroups.length + 1}");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Se creó ${nuevoCarrito.name}")),
              );
            },
            child: const Icon(Icons.shopping_cart_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "transactionsFab",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TransactionListScreen(),
                ),
              );
            },
            child: const Icon(Icons.swap_horiz),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "inventoryFab",
            onPressed: _openForm,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          Consumer<CartNotifier>(
            builder: (context, cart, _) => FloatingActionButton.extended(
              heroTag: "cartFab",
              onPressed: () async {
                if (cart.activeGroups.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No hay carritos activos")),
                  );
                  return;
                }

                final selected = await showDialog<int>(
                  context: context,
                  builder: (ctx) {
                    return SimpleDialog(
                      title: const Text("Selecciona un carrito"),
                      children: cart.activeGroups.map((group) {
                        return SimpleDialogOption(
                          onPressed: () => Navigator.pop(ctx, group.id),
                          child: Text(group.name ?? "Carrito ${group.id}"),
                        );
                      }).toList(),
                    );
                  },
                );

                if (selected != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartScreen(groupId: selected),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.shopping_cart),
              label: Text("Carritos (${cart.activeGroups.length})"),
            ),
          ),
        ],
      ),
    );
  }
}
