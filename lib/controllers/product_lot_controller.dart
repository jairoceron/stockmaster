import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/database/local/product_dao.dart';
import '../data/database/local/product_lots_dao.dart';

class ProductLotController {
  final ProductDao productDao;
  final ProductLotsDao productLotsDao;

  ProductLotController({
    required this.productDao,
    required this.productLotsDao,
  });



  /// 🔹 Mostrar formulario de edición
  void showEditBottomSheet(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Text("Formulario de edición para ${product.name}"),
          // Aquí puedes inyectar tu widget de edición real
        );
      },
    );
  }

  /// 🔹 Confirmar eliminación
  void confirmDelete(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Eliminar producto"),
        content: Text("¿Seguro que deseas eliminar ${product.name}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () async {
              await productDao.deleteProduct(product.id!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${product.name} eliminado")),
              );
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }


}
