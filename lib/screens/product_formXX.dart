import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../validators/product_form_validator.dart';
import '../services/bar_inventario.dart';
import '../screens/excepcion_personalizada.dart';
import '../screens/home_page.dart';
import '../providers/user_provider.dart';

class ProductFormXX extends StatefulWidget {
  const ProductFormXX({Key? key}) : super(key: key);

  @override
  State<ProductFormXX> createState() => _ProductFormXXState();
}

class _ProductFormXXState extends State<ProductFormXX> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  bool _isFormValid = false;
  Map<String, dynamic>? _insertedInventory;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final url = Uri.parse(
            "https://hsl36h9dj0.execute-api.us-east-2.amazonaws.com/dev/insertinventory");

        // Obtener el idbusiness desde el provider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final tenantid = userProvider.user?.tenantid;

        final body = jsonEncode({
          "idbusiness": tenantid, // ✅ ahora se usa el valor del provider
          "name": _nameController.text.trim(),
          "image":
          "assets/images/${_nameController.text.trim().replaceAll(' ', '-')}.jpg",
          "stock": int.parse(_stockController.text.trim()),
          "price": double.parse(_priceController.text.trim()),
        });

        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _insertedInventory = data["inventory"];
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Producto insertado exitosamente"),
              backgroundColor: Colors.green,
            ),
          );

          // Limpiar campos para permitir ingresar otro producto
          _nameController.clear();
          _stockController.clear();
          _priceController.clear();
          _validateForm();
        } else {
          ExcepcionPersonalizada(
            mensaje: "Error al insertar producto: ${response.body}",
            accion: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: "Home")),
              );
            },
          ).mostrar(context);
        }
      } catch (e) {
        ExcepcionPersonalizada(
          mensaje: "Excepción: $e",
          accion: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: "Home")),
            );
          },
        ).mostrar(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarInventario.buildAppBar(context, "Products"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_insertedInventory != null) ...[
              const Text(
                "Último producto insertado:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Name ocupa el 70% del ancho, ahora en color negro
                      Expanded(
                        flex: 7,
                        child: Text(
                          _insertedInventory!['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black, // ✅ color negro
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Stock con etiqueta
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Stock: ${_insertedInventory!['quantity']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Price en rojo
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${_insertedInventory!['price']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            Form(
              key: _formKey,
              onChanged: _validateForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Product name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.shopping_bag),
                    ),
                    validator: ProductFormValidator.validateName,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _stockController,
                    decoration: const InputDecoration(
                      labelText: "Stock current",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.inventory),
                    ),
                    keyboardType: TextInputType.number,
                    validator: ProductFormValidator.validateStock,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: ProductFormValidator.validatePrice,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _isFormValid ? _saveForm : null,
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}