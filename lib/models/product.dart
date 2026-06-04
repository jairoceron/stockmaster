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

  Product({
    this.id,
    this.idbusiness,
    this.idcategory,
    this.name,
    this.image,
    this.stock,
    required this.price,
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
  });

  Product copyWith({
    String? id,
    String? idbusiness,
    String? idcategory,
    String? name,
    String? image,
    int? stock,
    double? price,
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
  }) {
    return Product(
      id: id ?? this.id,
      idbusiness: idbusiness ?? this.idbusiness,
      idcategory: idcategory ?? this.idcategory,
      name: name ?? this.name,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      price: price ?? this.price,
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
    };
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
    );
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
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock, isdemo: $isdemo, syncstatus: $syncstatus, syncstate: $syncstate)';
  }
}
