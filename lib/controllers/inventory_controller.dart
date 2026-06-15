import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart'; // ✅ Import para el gauge circular
import '../models/product.dart';
import '../state/inventory_notifier.dart';
import '../theme/app_theme.dart';

class InventoryController {
  final BuildContext context;
  InventoryController(this.context);

  /// Actualizar stock (+/-)
  void updateStock(Product product, int delta) async {
    final provider = context.read<InventoryNotifier>();
    final newStock = (product.stock ?? 0) + delta;

    if (newStock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay suficientes unidades en stock')),
      );
      return;
    }

    try {
      await provider.updateStock(product, delta);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Stock de ${product.name} actualizado a $newStock')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar stock: $e')),
      );
    }
  }

  /// Confirmar eliminación de producto
  void confirmDelete(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Seguro que deseas eliminar ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final provider = context.read<InventoryNotifier>();
              await provider.eliminateProduct(product.id!);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Producto eliminado')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// Mostrar BottomSheet para editar producto con KPI circular de margen bruto
  void showEditBottomSheet(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);
    final stockController = TextEditingController(text: product.stock.toString());
    final priceController = TextEditingController(text: product.price.toString());
    final purchasePriceController =
    TextEditingController(text: product.purchaseprice?.toString() ?? '');

    double calculateMargin(double? purchasePrice, double? salePrice) {
      if (purchasePrice == null || purchasePrice <= 0 || salePrice == null) return 0;
      return ((salePrice - purchasePrice) / salePrice) * 100;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final theme = Theme.of(context);

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              double margin = calculateMargin(
                double.tryParse(purchasePriceController.text),
                double.tryParse(priceController.text),
              );

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Editar producto',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: stockController,
                      decoration: InputDecoration(
                        labelText: 'Stock',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    /// Renglón con Precio de compra y Precio de venta
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: purchasePriceController,
                            decoration: InputDecoration(
                              labelText: 'Precio de compra',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: 'Precio de venta',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// KPI de margen bruto con Syncfusion Gauge
                    Card(
                      color: margin >= 0
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Icon(
                              margin >= 0 ? Icons.trending_up : Icons.trending_down,
                              color: margin >= 0 ? Colors.green : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Margen Bruto: ${margin.toStringAsFixed(1)}%',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: margin >= 0 ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Rentabilidad sobre ventas',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: SfRadialGauge(
                                axes: <RadialAxis>[
                                  RadialAxis(
                                    minimum: 0,
                                    maximum: 100,
                                    showLabels: false,
                                    showTicks: false,
                                    axisLineStyle: AxisLineStyle(
                                      thickness: 0.15,
                                      cornerStyle: CornerStyle.bothCurve,
                                      color: Colors.grey.shade300,
                                      thicknessUnit: GaugeSizeUnit.factor,
                                    ),
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                        value: margin.clamp(0, 100),
                                        color: margin >= 0
                                            ? Colors.green
                                            : Colors.red,
                                        cornerStyle: CornerStyle.bothCurve,
                                        width: 0.15,
                                        sizeUnit: GaugeSizeUnit.factor,
                                      ),
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        widget: Text(
                                          '${margin.toStringAsFixed(0)}%',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: margin >= 0
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        angle: 90,
                                        positionFactor: 0.1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Guardar cambios',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        final provider = context.read<InventoryNotifier>();
                        final updated = product.copyWith(
                          name: nameController.text.trim(),
                          stock: int.tryParse(stockController.text) ?? 0,
                          price: double.tryParse(priceController.text) ?? 0.0,
                          purchaseprice: double.tryParse(
                              purchasePriceController.text) ?? 0.0,
                        );
                        await provider.modifyProduct(updated);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto actualizado con éxito'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
