import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/providers/BusinessProvider.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';
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
    var selectedType = context.read<InventoryTypeProvider>().inventoryType;

    if (selectedType == null || selectedType.isEmpty) {
      debugPrint("⚠️ InventoryTypeProvider está vacío, leyendo Business...");
      final businessDao = context.read<BusinessDao>();

      businessDao.getFirstBusiness().then((business) {
        if (business != null) {
          String? selectedType = context.read<InventoryTypeProvider>().inventoryType;

          if (selectedType == null || selectedType.isEmpty) {
            final businessDao = context.read<BusinessDao>();
            businessDao.getFirstBusiness().then((business) {
              if (business != null && business.typeinventory != null) {
                selectedType = business.typeinventory; // ✅ ahora no da error
                context.read<InventoryTypeProvider>().setInventoryType(selectedType!);
                notifier.loadAttributesForClient(selectedType!);
              }
            });
          } else {
            notifier.loadAttributesForClient(selectedType);
          }
          // actualizar provider
          context.read<InventoryTypeProvider>().setInventoryType(selectedType!);
          // opcional: guardar todo el negocio en BusinessProvider
          context.read<BusinessProvider>().setBusiness(business);

          notifier.loadAttributesForClient(selectedType!);
          debugPrint("*** ProductForm cargó atributos desde Business: $selectedType");
        }
      });
    } else {
      notifier.loadAttributesForClient(selectedType);
      debugPrint("*** ProductForm cargó atributos desde InventoryTypeProvider: $selectedType");
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
    debugPrint("\n\n Este es el $tenantid de la empresa \n\n");

    var stock = int.tryParse(_stockController.text.trim()) ?? 100;
    if (stock < 0) stock = 100;

    var nombreProducto = capitalizeWords(_nameController.text.trim());

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
        createdat: DateTime.now(),
        lastsyncedat: DateTime.now(),
      );

      try {
        context.read<InventoryNotifier>().addProduct(product);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('form.messages.success'.tr()),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${'form.messages.error'.tr()}: $e'),
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
        final baseSteps = [
          _buildStep(
            title: "form.name.label".tr(),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "form.name.label".tr(),
                hintText: "form.name.hint".tr(),
                prefixIcon: const Icon(Icons.shopping_bag),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "form.name.error".tr() : null,
            ),
          ),
          _buildStep(
            title: "form.stock.label".tr(),
            child: TextFormField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: "form.stock.label".tr(),
                hintText: "form.stock.hint".tr(),
                prefixIcon: const Icon(Icons.format_list_numbered),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                if (value == null || value.isEmpty) return "form.stock.error".tr();
                if (int.tryParse(value) == null) return "form.stock.error".tr();
                return null;
              },
            ),
          ),
          _buildStep(
            title: "form.price.label".tr(),
            child: TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: "form.price.label".tr(),
                hintText: "form.price.hint".tr(),
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) return "form.price.error".tr();
                if (double.tryParse(value) == null) return "form.price.error".tr();
                return null;
              },
            ),
          ),
          _buildStep(
            title: "form.barcode.label".tr(),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _barcodeController,
                    decoration: InputDecoration(
                      labelText: "form.barcode.label".tr(),
                      hintText: "form.barcode.hint".tr(),
                      prefixIcon: const Icon(Icons.qr_code),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return "form.barcode.error".tr();
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

        // 🔧 Aquí inicializamos los controladores dinámicos en el builder
        final dynamicSteps = attributeNotifier.clientAttributes.map((attr) {
          _attributeControllers.putIfAbsent(attr.fieldName, () => TextEditingController());
          return _buildStep(
            title: attr.fieldName,
            child: TextFormField(
              controller: _attributeControllers[attr.fieldName],
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
            title: Text('form.buttons.save'.tr()),
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
                          child: Text("form.buttons.back".tr()),
                        ),
                      if (_currentStep < steps.length - 1)
                        ElevatedButton(
                          onPressed: () => setState(() => _currentStep++),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: Text("form.buttons.next".tr()),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: () => _saveProduct(context, attributeNotifier),
                          icon: const Icon(Icons.check),
                          label: Text("form.buttons.save".tr()),
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
            color:Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
