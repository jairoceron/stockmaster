import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:provider/provider.dart';
// import 'package:mobile_scanner/mobile_scanner.dart'; // 👈 para escanear códigos
import 'package:stockmaster/state/attribute_notifier.dart';
import 'package:stockmaster/state/inventory_notifier.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';
import '/core/string_toools.dart';
import 'BarcodeScannerScreen.dart' show BarcodeScannerScreen;

class ProductForm extends StatefulWidget {
  const ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _attributeControllers = {};
  final _nameController = TextEditingController();
  final _stockController = TextEditingController();
  final _priceController = TextEditingController();
  final _barcodeController = TextEditingController();

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    final notifier = context.read<AttributeNotifier>();
    notifier.loadAttributesForClient("Salsamentaria"); // 👈 aquí defines el tipo

    // Inicializar controladores vacíos para cada atributo
    for (var attr in notifier.clientAttributes) {
      _attributeControllers[attr.fieldName] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    _barcodeController.dispose();

    for (var controller in _attributeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }


  void _openScanner() async {

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(
          onDetect: (code) {
            setState(() {
              _barcodeController.text = code;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );


  }

  void _saveProduct(BuildContext context, AttributeNotifier attributeNotifier) {

    final tenantid = context.read<UserProvider>().user.tenantid;
    debugPrint("\n\n Este es el $tenantid  de la empresa   \n\n");

    var stock = int.tryParse(_stockController.text.trim()) ?? 100;
    if (stock < 0) {
      stock = 100;
    }
    var nombreProducto = _nameController.text.trim();

    nombreProducto = capitalizeWords(nombreProducto);


    if (_formKey.currentState!.validate()) {
      final appUser = context.read<UserProvider>().user;
      final product = Product(
        name: nombreProducto,
        stock: stock,
        price: double.parse(_priceController.text.trim()),
        image: _nameController.text.trim(),
        idbusiness: tenantid,
        idcategory: _stockController.text.trim(),
        owner: appUser?.username,
        createdat : DateTime.now(),
        lastsyncedat : DateTime.now(),
      );

      try {
         // 👇 Aquí actualizas el provider
         context.read<InventoryNotifier>().addProduct(product);

         // está guardando dos veces (miremos si con esto se arregla .......********************************** se comentó la linea de arriba)
         // attributeNotifier.addProduct(product);
         // esto toca cuadrarlo para cuando los atributos son dinámicos .............

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Producto agregado con éxito'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AttributeNotifier>(
      builder: (context, attributeNotifier, _) {
        // pasos base
        final baseSteps = [
          _buildStep(
            title: "Nombre del producto",
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                hintText: "Ej. Camiseta Azul",
                prefixIcon: Icon(Icons.shopping_bag),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Ingresa el nombre" : null,
            ),
          ),
          _buildStep(
            title: "Stock inicial",
            child: TextFormField(
              controller: _stockController,
              decoration: const InputDecoration(
                labelText: "Stock",
                hintText: "Ej. 50",
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // ✅ solo dígitos
              validator: (value) {
                if (value == null || value.isEmpty) return "Ingresa el stock";
                if (int.tryParse(value) == null) return "Debe ser un número";
                return null;
              },
            ),
          ),
          _buildStep(
            title: "Precio",
            child: TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: "Precio",
                hintText: "Ej. 29.99",
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // ✅ solo dígitos
              validator: (value) {
                if (value == null || value.isEmpty) return "Ingresa el precio";
                if (double.tryParse(value) == null) {
                  return "Debe ser un número válido";
                }
                return null;
              },
            ),
          ),
          _buildStep(
            title: "Código de barras",
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _barcodeController,
                    decoration: const InputDecoration(
                      labelText: "Código de barras",
                      hintText: "Escanea o escribe",
                      prefixIcon: Icon(Icons.qr_code),
                    ),
                    readOnly: false,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "El código debe ser numérico";
                        }
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.orange),
                  onPressed: _openScanner,
                ),
              ],
            ),
          ),
        ];

        // pasos dinámicos desde AttributeNotifier
        final dynamicSteps = attributeNotifier.clientAttributes.map((attr) {
          // Crear controlador único si no existe
          _attributeControllers.putIfAbsent(attr.fieldName, () => TextEditingController());

          return _buildStep(
            title: attr.fieldName,
            child: TextFormField(
              controller: _attributeControllers[attr.fieldName], // ✅ ahora sí único
              decoration: InputDecoration(labelText: attr.fieldName),
              keyboardType: attr.fieldType.toLowerCase() == "int"
                  ? TextInputType.number
                  : TextInputType.text,
              validator: (value) {
                if (attr.isRequired && (value == null || value.isEmpty)) {
                  return "Campo obligatorio";
                }
                return null;
              },
              onSaved: (value) {
                attributeNotifier.setAttributeValueBusiness(
                  attr.fieldName,
                  value ?? "",
                );
              },
            ),
          );
        }).toList();



        final steps = [...baseSteps, ...dynamicSteps];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Agregar producto'),
            backgroundColor: Colors.orange,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  steps[_currentStep],
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentStep > 0)
                        OutlinedButton(
                          onPressed: () => setState(() => _currentStep--),
                          child: const Text("Atrás"),
                        ),
                      if (_currentStep < steps.length - 1)
                        ElevatedButton(
                          onPressed: () => setState(() => _currentStep++),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Text("Siguiente"),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: () =>
                              _saveProduct(context, attributeNotifier),
                          icon: const Icon(Icons.check),
                          label: const Text("Guardar producto"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

