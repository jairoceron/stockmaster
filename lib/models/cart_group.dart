import '../data/database/local/app_database.dart';

class CartGroup {
  final int id;
  final String? name;            // Carrito1, Orden mesa 5
  final bool processed;          // true si ya fue finalizado
  final DateTime createdAt;      // fecha de creación
  final bool syncStatus;         // estado de sincronización
  final DateTime? lastSyncedAt;  // última vez sincronizado
  final String syncState;        // pending, synced, etc.

  CartGroup({
    required this.id,
    this.name,
    this.processed = false,
    required this.createdAt,
    this.syncStatus = false,
    this.lastSyncedAt,
    this.syncState = 'pending',
  });

  /// Crear desde entidad Drift
  factory CartGroup.fromEntity(CartGroupEntity entity) {
    return CartGroup(
      id: entity.id,
      name: entity.name,
      processed: entity.processed,
      createdAt: entity.createdAt,
      syncStatus: entity.syncStatus,
      lastSyncedAt: entity.lastSyncedAt,
      syncState: entity.syncState,
    );
  }

  /// Convertir a entidad Drift (para inserts/updates)
  CartGroupEntity toEntity() {
    return CartGroupEntity(
      id: id,
      name: name,
      processed: processed,
      createdAt: createdAt,
      syncStatus: syncStatus,
      lastSyncedAt: lastSyncedAt,
      syncState: syncState,
    );
  }

  /// Copiar con cambios
  CartGroup copyWith({
    int? id,
    String? name,
    bool? processed,
    DateTime? createdAt,
    bool? syncStatus,
    DateTime? lastSyncedAt,
    String? syncState,
  }) {
    return CartGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      processed: processed ?? this.processed,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncState: syncState ?? this.syncState,
    );
  }

  /// Serialización a JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'processed': processed,
    'createdAt': createdAt.toIso8601String(),
    'syncStatus': syncStatus,
    'lastSyncedAt': lastSyncedAt?.toIso8601String(),
    'syncState': syncState,
  };

  /// Deserialización desde JSON
  factory CartGroup.fromJson(Map<String, dynamic> json) {
    return CartGroup(
      id: json['id'] as int,
      name: json['name'] as String?,
      processed: json['processed'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncStatus: json['syncStatus'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] != null
          ? DateTime.parse(json['lastSyncedAt'] as String)
          : null,
      syncState: json['syncState'] as String? ?? 'pending',
    );
  }
}
