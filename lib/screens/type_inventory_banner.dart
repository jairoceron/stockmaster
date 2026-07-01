import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/inventory_type_provider.dart';

/// 🔹 Widget reutilizable que muestra el tipo de inventario con tipografía moderna
class TypeInventoryBanner extends StatelessWidget {
  const TypeInventoryBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inventoryType = context.watch<InventoryTypeProvider>().inventoryType;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50, // tono más suave y elegante
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        inventoryType.isNotEmpty
            ? "T: $inventoryType"
            : "Inventario no definido",
        style: GoogleFonts.poppins(
          fontSize: 12, // más pequeño y delicado
          fontWeight: FontWeight.w400, // sin negrilla (peso normal)
          color: Colors.blueGrey.shade800, // tono elegante
          letterSpacing: 0.5, // ligera separación para sofisticación
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
