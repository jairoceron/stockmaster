import 'package:stockmaster/models/product.dart';

import 'dart:convert';
import 'product.dart'; // tu modelo Product

class CartItem {
  final Product product;
  int quantity; // 👈 mutable

  // Auditoría y sincronización
  final bool syncStatus;
  final DateTime? lastSyncedAt;
  final String syncState;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.syncStatus = false,
    this.lastSyncedAt,
    this.syncState = 'pending',
  });

  CartItem copyWith({
    Product? product,
    int? quantity,
    bool? syncStatus,
    DateTime? lastSyncedAt,
    String? syncState,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncState: syncState ?? this.syncState,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      syncStatus: json['syncStatus'] ?? false,
      lastSyncedAt: json['lastSyncedAt'] != null
          ? DateTime.tryParse(json['lastSyncedAt'].toString())
          : null,
      syncState: json['syncState']?.toString() ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'syncStatus': syncStatus,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'syncState': syncState,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] as int? ?? 1,
      syncStatus: map['syncStatus'] ?? false,
      lastSyncedAt: map['lastSyncedAt'] != null
          ? DateTime.tryParse(map['lastSyncedAt'].toString())
          : null,
      syncState: map['syncState']?.toString() ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
      'syncStatus': syncStatus,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'syncState': syncState,
    };
  }
}
