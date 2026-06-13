import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stockmaster/screens/bottom_navigation_bar.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import '../data/database/local/app_database.dart';
import '../data/database/local/product_dao.dart';
import '../data/database/local/products.dart';

import '../data/repositories/sqlite_product_service.dart';
import '/state/inventory_notifier.dart';

class MigrationScreen extends StatefulWidget {
  const MigrationScreen({Key? key}) : super(key: key);

  @override
  _MigrationScreenState createState() => _MigrationScreenState();
}

class _MigrationScreenState extends State<MigrationScreen> {
  // 🔹 Inicializa con el valor por defecto
  final TextEditingController _pathController = TextEditingController(
    text: "https://abcsoftbucket.s3.us-east-2.amazonaws.com/citricos/citricos.json",
  );
  String _statusMessage = "";

  late final AppDatabase _db;
  late final ProductDao _dao;
  late final SQLiteProductService _service;

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _dao = ProductDao(_db);
    _service = SQLiteProductService(_db);
  }

  Future<void> _readJsonFile() async {
    final path = _pathController.text.trim();
    if (path.isEmpty) {
      setState(() {
        _statusMessage = "Por favor ingresa la ruta del archivo en S3.";
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse(path));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final List<ProductsCompanion> productsList = jsonData.map((item) {
          return ProductsCompanion(
            idbusiness: drift.Value(item['idbusiness']?.toString()),
            name: drift.Value(item['name']),
            image: drift.Value(item['image']),
            stock: drift.Value(item['quantity']),
            price: drift.Value((item['price'] as num).toDouble()),
            createdat: drift.Value(DateTime.now()),
            syncstate: const drift.Value("pending"),
            syncstatus: const drift.Value(false),
            isdemo: const drift.Value(false),
          );
        }).toList();

        await _dao.insertInitialProducts(productsList);

        // 🔹 Actualizar el provider
        final provider = context.read<InventoryNotifier>();
        await provider.loadProducts();

        // 🔹 Redirigir automáticamente a la página principal
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavBar(initialIndex: 0),
          ),
        );
      } else {
        setState(() {
          _statusMessage = "Error al leer archivo: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Excepción: $e";
      });
    }
  }

  /// 🔹 Nueva función para borrar todos los productos usando el servicio
  Future<void> _deleteAllProducts() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar eliminación"),
        content: const Text(
            "¿Estás seguro de que quieres eliminar TODOS los productos de la base de datos? Esta acción no se puede deshacer."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _service.deleteAllProducts(); // 👈 llama al servicio
      final provider = context.read<InventoryNotifier>();
      await provider.deleteAllProducts(); // 👈 refresca la UI

      setState(() {
        _statusMessage = "Todos los productos fueron eliminados.";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Productos eliminados correctamente")),
      );
    }
  }

  @override
  void dispose() {
    _pathController.dispose();
    // _db.close();  _db.close(); // esto no se puede hacer nunca ...   // 👈 aquí cierras la base de datos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Migration Screen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pathController,
              decoration: const InputDecoration(
                labelText: "Ruta del archivo JSON en S3",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _readJsonFile,
              child: const Text("Leer archivo JSON"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _deleteAllProducts,
              child: const Text("Eliminar todos los productos"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_statusMessage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
