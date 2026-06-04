import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

import '../core/inicialization.dart';
import '../models/product.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class ProductFactory {
  // Puedes usar esto si quieres un timestamp fijo
  final createdAt = DateTime.now().toUtc().toIso8601String();

  static Future<Product> fromForm({
    required String id,
    required String idbusiness,
    required String name,
    required String stock,
    required String price,
    required String barcode,
    required AppUser? user,
  }) async {
    debugPrint("product_factory.dart");
    debugPrint("I am in this class: class ProductFactory { ");
    debugPrint(" \n\n\n  que es un patron de diseño factory \n\n\n ");

    // 👇 instancia tu clase de inicialización
    final init = Inicialization();
    final deviceId = await init.getDeviceId(); // ✅ await dentro de async
    debugPrint("Device ID: $deviceId");

    return Product(
      id: id, // UUID string
      name: name.trim().isNotEmpty ? name.trim() : 'unnamed product',
      stock: int.tryParse(stock.trim()) ?? 0,
      price: double.tryParse(price.trim()) ?? 0.0,
      image: 'assets/images/Miel_natural_1000gramos-300x300.jpeg',
      idbusiness: idbusiness, // ahora sí usa el argumento
      idcategory: '0', // o mapear desde el formulario
      owner: user?.username ?? 'system',
      createdat: DateTime.now().toUtc(),
      syncstatus: false,
      syncstate: 'pending',
      barcode: barcode, // o el valor que venga del formulario
      deviceid: deviceId, // valor real del dispositivo
      platform: Platform.isAndroid ? 'android' : 'ios',
    );
  }
}
