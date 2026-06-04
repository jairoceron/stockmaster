import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerScreen extends StatefulWidget {
  final Function(String) onDetect;

  const BarcodeScannerScreen({super.key, required this.onDetect});

  @override
   State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {

  final MobileScannerController cameraController = MobileScannerController();
  bool _alreadyDetected = false; // 👈 bandera para controlar lecturas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Escanear código")),
      body: MobileScanner(
        controller: cameraController,
        onDetect: (BarcodeCapture capture) {
          // Evita múltiples lecturas seguidas
          if (_alreadyDetected) return;
          _alreadyDetected = true;

          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final code = barcodes.first.rawValue ?? "";
            widget.onDetect(code); // 👈 pasa el valor al formulario

            // ❌ No hay Navigator.pop(context), la ventana sigue abierta
            // ✅ Si quisieras cerrarla automáticamente, aquí pondrías:
            // Navigator.pop(context);
          }
        },
      ),
    );
  }
}
