import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
import '../../utils/database_exporter.dart';

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController stockController;
  final TextEditingController priceController;
  final TextEditingController barcodeController;
  final VoidCallback onSaveAndAddAnother;
  final VoidCallback onSaveAndClose;

  const ProductForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.stockController,
    required this.priceController,
    required this.barcodeController,
    required this.onSaveAndAddAnother,
    required this.onSaveAndClose,
  }) : super(key: key);

  InputDecoration _inputDecoration(BuildContext context, String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface.withOpacity(0.05),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
      ),
    );
  }

  void _openScanner(BuildContext context) async {
    /*
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarcodeScannerScreen(
          onDetect: (code) {
            barcodeController.text = code; // se queda fijo en el campo
            Navigator.pop(context); // cierra solo el escáner
          },
        ),
      ),
    );*/
  }


  @override
  Widget build(BuildContext context) {
    return Align( // 👈 ancla el formulario arriba
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // 👈 evita que se expanda demasiado
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration(context, 'Product Name', Icons.label),
                validator: (value) => value == null || value.isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: stockController,
                decoration: _inputDecoration(context, 'Initial Stock', Icons.numbers),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter stock';
                  if (int.tryParse(value) == null) return 'Stock must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceController,
                decoration: _inputDecoration(context, 'Price', Icons.attach_money),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter price';
                  if (double.tryParse(value) == null) return 'Price must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: barcodeController,
                decoration: _inputDecoration(context, 'Barcode', Icons.qr_code),
                readOnly: true, // 👈 no abre teclado
                onTap: () => _openScanner(context), // 👈 abre cámara
                validator: (value) => value == null || value.isEmpty ? 'Scan barcode' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onSaveAndAddAnother,
                      icon: const Icon(Icons.add),
                      label: const Text('Save & Add Another'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onSaveAndClose,
                      icon: const Icon(Icons.check),
                      label: const Text('Save & Close'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  try {
                    await DatabaseExporter.exportAndShare();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Base de datos exportada con éxito')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error exportando base: $e')),
                    );
                  }
                },
                icon: const Icon(Icons.share),
                label: const Text('Exportar base de datos'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
class BarcodeScannerScreen extends StatefulWidget {
  final Function(String) onDetect;

  const BarcodeScannerScreen({required this.onDetect, Key? key}) : super(key: key);

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController cameraController = MobileScannerController();
  bool _alreadyDetected = false; // 👈 evita lecturas múltiples

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear código")),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (BarcodeCapture capture) {
          if (_alreadyDetected) return; // 👈 solo una vez
          _alreadyDetected = true;

          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final code = barcodes.first.rawValue ?? "";
            widget.onDetect(code); // 👈 pasa el valor al formulario
            // ❌ NO hay Navigator.pop(context), la ventana sigue abierta
            // Si quieres que el usuario pueda seguir escaneando, quita la bandera y deja que se dispare varias veces
          }
        },
      ),
    );
  }
}
*/