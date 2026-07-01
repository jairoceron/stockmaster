import 'dart:convert';
import 'package:drift/drift.dart';
import '../data/database/local/app_database.dart';

class ImageStockmaster {
  final String? id;            // uuid string
  final String path;           // ruta local o URL
  final String ownerType;      // tipo de entidad (product, client, etc.)
  final String ownerId;        // id del dueño
  final String? thumbnailPath; // miniatura opcional
  final DateTime createdAt;    // fecha de creación

  ImageStockmaster({
    this.id,
    required this.path,
    required this.ownerType,
    required this.ownerId,
    this.thumbnailPath,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Copia con cambios
  ImageStockmaster copyWith({
    String? id,
    String? path,
    String? ownerType,
    String? ownerId,
    String? thumbnailPath,
    DateTime? createdAt,
  }) {
    return ImageStockmaster(
      id: id ?? this.id,
      path: path ?? this.path,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Conversión desde JSON
  factory ImageStockmaster.fromJson(Map<String, dynamic> json) {
    return ImageStockmaster(
      id: json['id']?.toString(),
      path: json['path'] as String,
      ownerType: json['ownerType'] as String,
      ownerId: json['ownerId'] as String,
      thumbnailPath: json['thumbnailPath'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  /// Conversión desde Map (ej. BD)
  factory ImageStockmaster.fromMap(Map<String, dynamic> map) {
    return ImageStockmaster(
      id: map['id']?.toString(),
      path: map['path'] as String,
      ownerType: map['ownerType'] as String,
      ownerId: map['ownerId'] as String,
      thumbnailPath: map['thumbnailPath'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  /// Conversión a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'path': path,
      'ownerType': ownerType,
      'ownerId': ownerId,
      'thumbnailPath': thumbnailPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Conversión a Map (ej. para BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
      'ownerType': ownerType,
      'ownerId': ownerId,
      'thumbnailPath': thumbnailPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ImageStockmaster(id: $id, path: $path, ownerType: $ownerType, '
        'ownerId: $ownerId, thumbnailPath: $thumbnailPath, createdAt: $createdAt)';
  }

  /// 🔹 Conversión desde entidad Drift
  factory ImageStockmaster.fromEntity(ImageStockmasterEntity entity) {
    return ImageStockmaster(
      id: entity.id,
      path: entity.path,
      ownerType: entity.ownerType,
      ownerId: entity.ownerId,
      thumbnailPath: entity.thumbnailPath,
      createdAt: entity.createdAt,
    );
  }

  /// 🔹 Conversión a entidad Drift
  ImageStockmasterEntity toEntity() {
    return ImageStockmasterEntity(
      id: id ?? '',
      path: path,
      ownerType: ownerType,
      ownerId: ownerId,
      thumbnailPath: thumbnailPath,
      createdAt: createdAt,
      updatedAt: createdAt,
    );
  }
}
