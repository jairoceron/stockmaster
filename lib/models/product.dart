import 'dart:convert';
import 'package:drift/drift.dart';
import '../data/database/local/app_database.dart';

class Product {
  final String? id; // uuid string
  final String? idbusiness;
  final String? idcategory;
  final String? name;
  String? image;
  final int? stock;
  final double price;
  final double? purchaseprice; // 🔹 precio de compra
  final DateTime? createdat;
  final String? owner;
  final String? barcode;
  final int? stockminimumlevel;
  final String? deviceid;
  final String? platform;
  final String? ubicacion;
  final String? bodega;

  // auditoría y sincronización
  final bool? syncstatus;
  final DateTime? lastsyncedat;
  final String? syncstate;

  // inventario demo
  final bool? isdemo;

  // 🔹 Campos adicionales recomendados
  final DateTime? expiryDate;
  final String? unit;
  final double? taxRate;
  final String? status;
  final String? supplier;
  final double? averageCost;
  final String? aisle;
  final String? shelf;
  final String? description;

  Product({
    this.id,
    this.idbusiness,
    this.idcategory,
    this.name,
    this.image,
    this.stock,
    required this.price,
    this.purchaseprice,
    this.createdat,
    this.owner,
    this.barcode,
    this.stockminimumlevel,
    this.deviceid,
    this.platform,
    this.ubicacion,
    this.bodega,
    this.syncstatus = false,
    this.lastsyncedat,
    this.syncstate = 'pending',
    this.isdemo = false,
    this.expiryDate,
    this.unit,
    this.taxRate,
    this.status,
    this.supplier,
    this.averageCost,
    this.aisle,
    this.shelf,
    this.description,
  });

  Product copyWith({
    String? id,
    String? idbusiness,
    String? idcategory,
    String? name,
    String? image,
    int? stock,
    double? price,
    double? purchaseprice,
    DateTime? createdat,
    String? owner,
    String? barcode,
    int? stockminimumlevel,
    String? deviceid,
    String? platform,
    String? ubicacion,
    String? bodega,
    bool? syncstatus,
    DateTime? lastsyncedat,
    String? syncstate,
    bool? isdemo,
    DateTime? expiryDate,
    String? unit,
    double? taxRate,
    String? status,
    String? supplier,
    double? averageCost,
    String? aisle,
    String? shelf,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      idbusiness: idbusiness ?? this.idbusiness,
      idcategory: idcategory ?? this.idcategory,
      name: name ?? this.name,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      purchaseprice: purchaseprice ?? this.purchaseprice,
      createdat: createdat ?? this.createdat,
      owner: owner ?? this.owner,
      barcode: barcode ?? this.barcode,
      stockminimumlevel: stockminimumlevel ?? this.stockminimumlevel,
      deviceid: deviceid ?? this.deviceid,
      platform: platform ?? this.platform,
      ubicacion: ubicacion ?? this.ubicacion,
      bodega: bodega ?? this.bodega,
      syncstatus: syncstatus ?? this.syncstatus,
      lastsyncedat: lastsyncedat ?? this.lastsyncedat,
      syncstate: syncstate ?? this.syncstate,
      isdemo: isdemo ?? this.isdemo,
      expiryDate: expiryDate ?? this.expiryDate,
      unit: unit ?? this.unit,
      taxRate: taxRate ?? this.taxRate,
      status: status ?? this.status,
      supplier: supplier ?? this.supplier,
      averageCost: averageCost ?? this.averageCost,
      aisle: aisle ?? this.aisle,
      shelf: shelf ?? this.shelf,
      description: description ?? this.description,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      idbusiness: json['idbusiness']?.toString(),
      idcategory: json['idcategory']?.toString(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      stock: json['stock'] != null ? int.tryParse(json['stock'].toString()) : null,
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      purchaseprice: json['purchaseprice'] != null
          ? double.tryParse(json['purchaseprice'].toString())
          : null,
      createdat: json['createdat'] != null ? DateTime.tryParse(json['createdat'].toString()) : null,
      owner: json['owner'] as String?,
      barcode: json['barcode'] as String?,
      stockminimumlevel: json['stockminimumlevel'] != null ? int.tryParse(json['stockminimumlevel'].toString()) : null,
      deviceid: json['deviceid'] as String?,
      platform: json['platform'] as String?,
      ubicacion: json['ubicacion'] as String?,
      bodega: json['bodega'] as String?,
      syncstatus: json['syncstatus'] ?? false,
      lastsyncedat: json['lastsyncedat'] != null ? DateTime.tryParse(json['lastsyncedat'].toString()) : null,
      syncstate: json['syncstate']?.toString() ?? 'pending',
      isdemo: json['isdemo'] == true || json['isdemo'] == 1,
      expiryDate: json['expiryDate'] != null ? DateTime.tryParse(json['expiryDate'].toString()) : null,
      unit: json['unit']?.toString(),
      taxRate: json['taxRate'] != null ? double.tryParse(json['taxRate'].toString()) : null,
      status: json['status']?.toString(),
      supplier: json['supplier']?.toString(),
      averageCost: json['averageCost'] != null ? double.tryParse(json['averageCost'].toString()) : null,
      aisle: json['aisle']?.toString(),
      shelf: json['shelf']?.toString(),
      description: json['description']?.toString(),
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString(),
      idbusiness: map['idbusiness']?.toString(),
      idcategory: map['idcategory']?.toString(),
      name: map['name'] as String?,
      image: map['image'] as String?,
      stock: map['stock'] as int?,
      price: (map['price'] as num).toDouble(),
      purchaseprice: map['purchaseprice'] != null ? (map['purchaseprice'] as num).toDouble() : null,
      createdat: map['createdat'] != null ? DateTime.tryParse(map['createdat'].toString()) : null,
      owner: map['owner'] as String?,
      barcode: map['barcode'] as String?,
      stockminimumlevel: map['stockminimumlevel'] as int?,
      deviceid: map['deviceid'] as String?,
      platform: map['platform'] as String?,
      ubicacion: map['ubicacion'] as String?,
      bodega: map['bodega'] as String?,
      syncstatus: map['syncstatus'] ?? false,
      lastsyncedat: map['lastsyncedat'] != null ? DateTime.tryParse(map['lastsyncedat'].toString()) : null,
      syncstate: map['syncstate']?.toString() ?? 'pending',
      isdemo: map['isdemo'] == true || map['isdemo'] == 1,
      expiryDate: map['expiryDate'] != null ? DateTime.tryParse(map['expiryDate'].toString()) : null,
      unit: map['unit']?.toString(),
      taxRate: map['taxRate'] != null ? (map['taxRate'] as num).toDouble() : null,
      status: map['status']?.toString(),
      supplier: map['supplier']?.toString(),
      averageCost: map['averageCost'] != null ? (map['averageCost'] as num).toDouble() : null,
      aisle: map['aisle']?.toString(),
      shelf: map['shelf']?.toString(),
      description: map['description']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idbusiness': idbusiness,
      'idcategory': idcategory,
      'name': name,
      'image': image,
      'stock': stock,
      'price': price,
      'purchaseprice': purchaseprice,
      'createdat': createdat?.toIso8601String(),
      'owner': owner,
      'barcode': barcode,
      'stockminimumlevel': stockminimumlevel,
      'deviceid': deviceid,
      'platform': platform,
      'ubicacion': ubicacion,
      'bodega': bodega,
      'syncstatus': syncstatus,
      'lastsyncedat': lastsyncedat?.toIso8601String(),
      'syncstate': syncstate,
      'isdemo': isdemo,
      // 🔹 Campos adicionales
      'expiryDate': expiryDate?.toIso8601String(),
      'unit': unit,
      'taxRate': taxRate,
      'status': status,
      'supplier': supplier,
      'averageCost': averageCost,
      'aisle': aisle,
      'shelf': shelf,
      'description': description,
    };
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idbusiness': idbusiness,
      'idcategory': idcategory,
      'name': name,
      'image': image,
      'stock': stock,
      'price': price,
      'purchaseprice': purchaseprice,
      'createdat': createdat?.toIso8601String(),
      'owner': owner,
      'barcode': barcode,
      'stockminimumlevel': stockminimumlevel,
      'deviceid': deviceid,
      'platform': platform,
      'ubicacion': ubicacion,
      'bodega': bodega,
      'syncstatus': syncstatus,
      'lastsyncedat': lastsyncedat?.toIso8601String(),
      'syncstate': syncstate,
      'isdemo': isdemo,
      'expiryDate': expiryDate?.toIso8601String(),
      'unit': unit,
      'taxRate': taxRate,
      'status': status,
      'supplier': supplier,
      'averageCost': averageCost,
      'aisle': aisle,
      'shelf': shelf,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, purchaseprice: $purchaseprice, '
        'stock: $stock, expiryDate: $expiryDate, unit: $unit, taxRate: $taxRate, '
        'status: $status, supplier: $supplier, averageCost: $averageCost, '
        'aisle: $aisle, shelf: $shelf, description: $description, '
        'isdemo: $isdemo, syncstatus: $syncstatus, syncstate: $syncstate)';
  }


}
