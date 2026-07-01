import 'dart:convert';

class Service {
  final String? id; // uuid string
  final String? idBusiness;
  final String? idCategory;
  final String? name;
  final String? description;
  final String? image;
  final double? price;
  final int? durationMinutes;
  final String? professional;
  final double? taxRate;
  final String? status;

  // sincronización
  final String? syncState;
  final bool? syncStatus;
  final bool? isDemo;

  // timestamps
  final DateTime? createdAt;
  final DateTime? lastSyncedAt;

  Service({
    this.id,
    this.idBusiness,
    this.idCategory,
    this.name,
    this.description,
    this.image,
    this.price,
    this.durationMinutes,
    this.professional,
    this.taxRate,
    this.status,
    this.syncState = 'pending',
    this.syncStatus = false,
    this.isDemo = false,
    this.createdAt,
    this.lastSyncedAt,
  });

  Service copyWith({
    String? id,
    String? idBusiness,
    String? idCategory,
    String? name,
    String? description,
    String? image,
    double? price,
    int? durationMinutes,
    String? professional,
    double? taxRate,
    String? status,
    String? syncState,
    bool? syncStatus,
    bool? isDemo,
    DateTime? createdAt,
    DateTime? lastSyncedAt,
  }) {
    return Service(
      id: id ?? this.id,
      idBusiness: idBusiness ?? this.idBusiness,
      idCategory: idCategory ?? this.idCategory,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      professional: professional ?? this.professional,
      taxRate: taxRate ?? this.taxRate,
      status: status ?? this.status,
      syncState: syncState ?? this.syncState,
      syncStatus: syncStatus ?? this.syncStatus,
      isDemo: isDemo ?? this.isDemo,
      createdAt: createdAt ?? this.createdAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id']?.toString(),
      idBusiness: json['idBusiness']?.toString(),
      idCategory: json['idCategory']?.toString(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: json['price'] != null ? double.tryParse(json['price'].toString()) : null,
      durationMinutes: json['durationMinutes'] != null ? int.tryParse(json['durationMinutes'].toString()) : null,
      professional: json['professional'] as String?,
      taxRate: json['taxRate'] != null ? double.tryParse(json['taxRate'].toString()) : null,
      status: json['status'] as String?,
      syncState: json['syncState']?.toString() ?? 'pending',
      syncStatus: json['syncStatus'] == true || json['syncStatus'] == 1,
      isDemo: json['isDemo'] == true || json['isDemo'] == 1,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.tryParse(json['lastSyncedAt'].toString()) : null,
    );
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id']?.toString(),
      idBusiness: map['idBusiness']?.toString(),
      idCategory: map['idCategory']?.toString(),
      name: map['name'] as String?,
      description: map['description'] as String?,
      image: map['image'] as String?,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      durationMinutes: map['durationMinutes'] as int?,
      professional: map['professional'] as String?,
      taxRate: map['taxRate'] != null ? (map['taxRate'] as num).toDouble() : null,
      status: map['status'] as String?,
      syncState: map['syncState']?.toString() ?? 'pending',
      syncStatus: map['syncStatus'] ?? false,
      isDemo: map['isDemo'] ?? false,
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt'].toString()) : null,
      lastSyncedAt: map['lastSyncedAt'] != null ? DateTime.tryParse(map['lastSyncedAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idBusiness': idBusiness,
      'idCategory': idCategory,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'durationMinutes': durationMinutes,
      'professional': professional,
      'taxRate': taxRate,
      'status': status,
      'syncState': syncState,
      'syncStatus': syncStatus,
      'isDemo': isDemo,
      'createdAt': createdAt?.toIso8601String(),
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idBusiness': idBusiness,
      'idCategory': idCategory,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'durationMinutes': durationMinutes,
      'professional': professional,
      'taxRate': taxRate,
      'status': status,
      'syncState': syncState,
      'syncStatus': syncStatus,
      'isDemo': isDemo,
      'createdAt': createdAt?.toIso8601String(),
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Service(id: $id, name: $name, price: $price, durationMinutes: $durationMinutes, '
        'professional: $professional, taxRate: $taxRate, status: $status, '
        'syncState: $syncState, syncStatus: $syncStatus, isDemo: $isDemo, '
        'createdAt: $createdAt, lastSyncedAt: $lastSyncedAt)';
  }
}
