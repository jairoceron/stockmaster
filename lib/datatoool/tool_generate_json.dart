import 'dart:convert';
import 'dart:math';

void main() {
  final productsJson = [
    { "idbusiness": 1, "name": "Newprolys spray", "image": "assets/images/newprolys_pray-300x300.jpeg", "quantity": 80, "price": 29000 },
    { "idbusiness": 1, "name": "Propóleo compuesto 300 gramos", "image": "assets/images/propoleo_compuesto_300gramos-300x300.jpeg", "quantity": 80, "price": 26000 },
    { "idbusiness": 1, "name": "Miel 1000 gramos", "image": "assets/images/Miel_natural_1000gramos-300x300.jpeg", "quantity": 80, "price": 40000 },
    { "idbusiness": 1, "name": "Miel Natural 300 gramos", "image": "assets/images/miel_Naturalx300gramos-600x600.jpeg", "quantity": 80, "price": 15000 },
    { "idbusiness": 1, "name": "Miel Natural 175 gramos", "image": "assets/images/miel_natural_175gramos-600x600.jpeg", "quantity": 80, "price": 9500 },
    { "idbusiness": 1, "name": "Protector Labial de Cera de Abejas", "image": "assets/images/protector_labial-600x600.jpeg", "quantity": 80, "price": 13000 },
    { "idbusiness": 1, "name": "Marco de Alza", "image": "assets/images/MARCO-DE-ALZA-600x600.jpg", "quantity": 80, "price": 3200 },
    { "idbusiness": 1, "name": "Propolis Gotero", "image": "assets/images/propolis_Gotero-600x600.jpeg", "quantity": 80, "price": 24000 },
    { "idbusiness": 1, "name": "Propóleo Natural 300 gramos", "image": "assets/images/propoleo_compuesto_300gramos-300x300.jpeg", "quantity": 80, "price": 24000 },
    { "idbusiness": 1, "name": "Café Mullalpa", "image": "assets/images/CAFE-300x300.jpg", "quantity": 80, "price": 45000 },
    { "idbusiness": 1, "name": "Ahumador", "image": "assets/images/ahumador-300x300.jpg", "quantity": 80, "price": 95000 },
    { "idbusiness": 1, "name": "Miel 27 Kilos", "image": "assets/images/MIEL-X-20-KG.jpg", "quantity": 80, "price": 491000 },
    { "idbusiness": 1, "name": "Panal de miel por gramo", "image": "assets/images/panal-de-miel-600x600.jpg", "quantity": 80, "price": 6000 },
    { "idbusiness": 1, "name": "Turrón Chocolate 50 Gramos", "image": "assets/images/turron-600x600.png", "quantity": 80, "price": 6500 },
    { "idbusiness": 1, "name": "Jusira Jarea Paquete x7 unidades", "image": "assets/images/Jusira_Jarea_paquete_7_unidades-600x600.jpeg", "quantity": 80, "price": 54000 },
    { "idbusiness": 1, "name": "Polen WayraSua 1000 gramos", "image": "assets/images/polen-100g.jpg", "quantity": 80, "price": 47000 },
    { "idbusiness": 1, "name": "Polen WayraSua 500 gramos", "image": "assets/images/polen_500_gramos.jpeg", "quantity": 80, "price": 25000 },
    { "idbusiness": 1, "name": "Polen WayraSua 250 gramos", "image": "assets/images/Polen_wayraSua_250_gramos-600x600.jpeg", "quantity": 80, "price": 15000 },
    { "idbusiness": 1, "name": "Polen WayraSua 125 gramos", "image": "assets/images/Polen_wayraSua_125_gramos-600x600.jpeg", "quantity": 80, "price": 8500 },
    { "idbusiness": 1, "name": "Miel WayraSua 330 gramos", "image": "assets/images/wayrasua300g2.jpg", "quantity": 80, "price": 15000 },
    { "idbusiness": 1, "name": "Miel Natural 1000 gramos", "image": "assets/images/Miel_natural_1000gramos-300x300.jpeg", "quantity": 80, "price": 45000 },
    { "idbusiness": 1, "name": "Cepillo", "image": "assets/images/cepillo-600x600.jpg", "quantity": 80, "price": 19000 },
    { "idbusiness": 1, "name": "Achiras", "image": "assets/images/ACHIRAS-600x600.jpg", "quantity": 80, "price": 6000 },
    { "idbusiness": 1, "name": "Palanca", "image": "assets/images/PALA-600x600.jpg", "quantity": 80, "price": 28000 },
    { "idbusiness": 1, "name": "Miel 5 Kilos", "image": "assets/images/MIEL-X-5-KG-600x600.jpg", "quantity": 80, "price": 151000 },
    { "idbusiness": 1, "name": "Cera de abejas", "image": "assets/images/cera-de-abejas-600x600.jpg", "quantity": 80, "price": 62000 },
    { "idbusiness": 1, "name": "Guantes", "image": "assets/images/guantes-600x600.jpg", "quantity": 80, "price": 30000 },
    { "idbusiness": 1, "name": "Overol en malla", "image": "assets/images/OVEROL-EN-MALLA-2-PIEZAS-TIPO-HILDE-300x300.jpg", "quantity": 80, "price": 140000 },
    { "idbusiness": 1, "name": "Overol espumoso", "image": "assets/images/OVEROL-ESPUMOSO-300x300.jpg", "quantity": 80, "price": 140000 },
    { "idbusiness": 1, "name": "Overol en Dril", "image": "assets/images/OVEROL-EN-DRIL-300x300.jpg", "quantity": 80, "price": 140000 },
    { "idbusiness": 1, "name": "Jalea Real", "image": "assets/images/Jalea-Real-600x600.jpg", "quantity": 80, "price": 75000 },
    { "idbusiness": 1, "name": "Base Piquera", "image": "assets/images/BASE-O-PIQUERA-600x600.jpg", "quantity": 80, "price": 24000 },
    { "idbusiness": 1, "name": "Marco profundo", "image": "assets/images/MARCO-PROFUNDO-600x600.jpg", "quantity": 80, "price": 3600 },
    { "idbusiness": 1, "name": "Cámara profunda", "image": "assets/images/CAMARA-PROFUNDA-600x600.jpg", "quantity": 80, "price": 38000 },
    { "idbusiness": 1, "name": "Tapa interna", "image": "assets/images/TAPA-INTERNA-600x600.jpg", "quantity": 80, "price": 23000 },
    { "idbusiness": 1, "name": "Techo colmena", "image": "assets/images/techo-600x600.jpg", "quantity": 80, "price": 28000 },
    { "idbusiness": 1, "name": "Colmena Completa", "image": "assets/images/COLMENA-COMPLETA-300x300.jpg", "quantity": 80, "price": 280000 },
    { "idbusiness": 1, "name": "Alza", "image": "assets/images/ALZA-300x300.jpg", "quantity": 80, "price": 28000 },
    { "idbusiness": 1, "name": "Turrón Chocolate 125 Gramos", "image": "assets/images/turron-600x600.png", "quantity": 80, "price": 13000 },
    { "idbusiness": 1, "name": "Granola", "image": "assets/images/Granola-600x600.jpg", "quantity": 80, "price": 40000 },
    { "idbusiness": 1, "name": "Vinum Acre", "image": "assets/images/vinagre-600x600.jpg", "quantity": 80, "price": 21000 },
    { "idbusiness": 1, "name": "Galletas Lebkuchen", "image": "assets/images/galletas_lebkuchen-600x600.jpeg", "quantity": 80, "price": 5000 },
    { "idbusiness": 1, "name": "Polen 500 gramos", "image": "assets/images/polen_500_gramos.jpeg", "quantity": 80, "price": 27000 },
    { "idbusiness": 1, "name": "Polen 250 gramos", "image": "assets/images/polen_250gramos.jpeg", "quantity": 80, "price": 18000 },
    { "idbusiness": 1, "name": "Miel WayraSua 500 gramos", "image": "assets/images/miel_wayraSua_500gramos-600x600.jpeg", "quantity": 80, "price": 25000 },
    { "idbusiness": 1, "name": "Polen 500 gramos", "image": "assets/images/polen_500_gramos.jpeg", "quantity": 80, "price": 27000 },
    { "idbusiness": 1, "name": "Polen 250 gramos", "image": "assets/images/polen_250gramos.jpeg", "quantity": 80, "price": 18000 },
    { "idbusiness": 1, "name": "Miel WayraSua 500 gramos", "image": "assets/images/miel_wayraSua_500gramos-600x600.jpeg", "quantity": 80, "price": 25000 },
    { "idbusiness": 1, "name": "Miel Natural x 700 gramos", "image": "assets/images/700g-300x300.jpg", "quantity": 80, "price": 29800 }
  ]  ;

  final rnd = Random();
  final List<Map<String, dynamic>> scenarios = [];

  for (var product in productsJson) {
    final productId = _generateUuid();
    final productBlock = {
      "product": {
        "id": productId,
        "name": product["name"],
        "stock": (product["quantity"] as num).toInt(),
        "precio": (product["price"] as num).toInt(),
        "image": product["image"],
      },
      "inventoryMovements": <Map<String, dynamic>>[],
    };

    int currentStock = (product["quantity"] as num).toInt();

    // Generar exactamente 3 movimientos simulados coherentes en orden cronológico
    DateTime baseDate = DateTime.now().subtract(const Duration(days: 30));
    for (int i = 0; i < 3; i++) {
      final isEntrada = rnd.nextBool();
      int qty = rnd.nextInt(100) + 1;
      final prevStock = currentStock;

      int newStock;
      String note;

      if (isEntrada) {
        // Entrada: sumar al stock
        newStock = prevStock + qty;
        note = "Compra proveedor";
      } else {
        // Salida: restar al stock, nunca negativo
        if (qty > prevStock) {
          qty = prevStock; // ajustar a lo disponible
        }
        newStock = prevStock - qty;
        note = "Venta en almacén";
      }

      currentStock = newStock;

      final movementDate = baseDate.add(Duration(days: i * 5, hours: rnd.nextInt(24)));

      (productBlock["inventoryMovements"] as List<Map<String, dynamic>>).add({
        "id": _generateUuid(),
        "productId": productId,
        "movementType": isEntrada ? "entrada" : "salida",
        "quantity": qty,
        "previousStock": prevStock,
        "newStock": newStock,
        "note": note,
        "timestamp": movementDate.toIso8601String(),
      });
    }

    scenarios.add(productBlock);
  }

  final jsonOutput = const JsonEncoder.withIndent("  ").convert(scenarios);
  print(jsonOutput);
}

/// Generador simple de UUID v4
String _generateUuid() {
  final rnd = Random();
  return "${rnd.nextInt(0xffffffff).toRadixString(16).padLeft(8, '0')}-"
      "${rnd.nextInt(0xffff).toRadixString(16).padLeft(4, '0')}-"
      "4${rnd.nextInt(0xfff).toRadixString(16).padLeft(3, '0')}-"
      "${(rnd.nextInt(0x3fff) + 0x8000).toRadixString(16).padLeft(4, '0')}-"
      "${rnd.nextInt(0xfff).toRadixString(16).padLeft(12, '0')}";
}