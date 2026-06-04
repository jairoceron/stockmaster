import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ingreso_inventario_screen.dart';
import 'product_detail.dart';
import '/helpers/navigation/navigation.dart';
import '../providers/user_provider.dart';
import '/screens/excepcion_personalizada.dart';
import 'home_page.dart';
import '/services/bar_inventario.dart'; // ✅ Importamos el encabezado
import 'package:provider/provider.dart';

class InventoryScreenXX extends StatefulWidget {
  const InventoryScreenXX({super.key}); // 👈 Constructor sin parámetros

  @override
  _InventoryScreenXXState createState() => _InventoryScreenXXState();
}

class _InventoryScreenXXState extends State<InventoryScreenXX> {
  List<Map<String, dynamic>> products = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    // 👇 Ya no usamos widget.idbusinessX, lo obtenemos del Provider
    final appUser = Provider.of<UserProvider>(context, listen: false).user;
    if (appUser != null) {
     // fetchInventory(appUser.idbusiness);
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchInventory(int idbusinessX) async {
    const url =
        'https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/mielInventory';

    try {
      print(" ESTE ES EL IDBUSINESS: $idbusinessX");
      final body = jsonEncode({"idbusinessP": idbusinessX});

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        dynamic bodyJson;

        if (decoded is Map && decoded.containsKey('body')) {
          final bodyField = decoded['body'];
          bodyJson = bodyField is String ? jsonDecode(bodyField) : bodyField;
        } else {
          bodyJson = decoded;
        }

        if (bodyJson == null || bodyJson is! List) {
          ExcepcionPersonalizada(
            mensaje:
            "Debe primero ingresar el inventario de productos de su empresa.",
            accion: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyHomePage(title: 'Inicio'),
                ),
              );
            },
          ).mostrar(context);

          setState(() {
            loading = false;
            products = [];
          });
          return;
        }

        setState(() {
          products = (bodyJson as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();
          loading = false;
        });
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      ExcepcionPersonalizada(
        mensaje:
        "Debe primero ingresar el inventario de productos de su empresa.",
        accion: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const MyHomePage(title: 'Inicio'),
            ),
          );
        },
      ).mostrar(context);
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: BarInventario.buildAppBar(context, "Inventario"),
      body: products.isEmpty
          ? const Center(
        child: Text("No hay productos en el inventario"),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          final imagePath = product["image"]?.toString().trim();
          final hasValidImage =
              imagePath != null && imagePath.isNotEmpty;

          return Card(
            elevation: 3,
            child: Column(
              children: [
                Expanded(
                  child: hasValidImage
                      ? Image.asset(
                    imagePath!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.inventory_2,
                          size: 80, color: Colors.grey);
                    },
                  )
                      : const Icon(Icons.inventory_2,
                      size: 80, color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    final idProd =
                        int.tryParse(product["id"]?.toString() ?? "0") ??
                            0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(idProducto: idProd),
                      ),
                    );
                  },
                  child: Text(product["name"] ?? "Producto"),
                ),
                Text("Cantidad: ${product["quantity"] ?? 0}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          NavigationHelpers.navigateToIngresoInventario(
                            context: context,
                            product: products[index],
                            transactionType: "output",
                            onQuantityUpdated: (newQuantity) {
                              setState(() {
                                products[index]["quantity"] =
                                    (products[index]["quantity"] ?? 0) -
                                        newQuantity;
                              });
                            },
                          );
                        },
                        child: const Icon(Icons.remove,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${products[index]["quantity"] ?? 0}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          NavigationHelpers.navigateToIngresoInventario(
                            context: context,
                            product: products[index],
                            transactionType: "input",
                            onQuantityUpdated: (newQuantity) {
                              setState(() {
                                products[index]["quantity"] =
                                    (products[index]["quantity"] ?? 0) +
                                        newQuantity;
                              });
                            },
                          );
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}