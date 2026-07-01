class ThirdPart {
  final String id;
  final String? idbusiness;
  final String? documentType;
  final String? documentNumber;
  final String? imageUrl;
  final String? thirdPartType;
  final String name;
  final String? country;
  final String? city;
  final String? address;
  final String? phone;
  final String? email;
  final String? instagram;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ThirdPart({
    required this.id,
    this.idbusiness,
    this.documentType,
    this.documentNumber,
    this.imageUrl,
    this.thirdPartType,
    required this.name,
    this.country,
    this.city,
    this.address,
    this.phone,
    this.email,
    this.instagram,
    this.notes,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// 🔹 Crear nueva instancia con cambios
  ThirdPart copyWith({
    String? id,
    String? idbusiness,
    String? documentType,
    String? documentNumber,
    String? imageUrl,
    String? thirdPartType,
    String? name,
    String? country,
    String? city,
    String? address,
    String? phone,
    String? email,
    String? instagram,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ThirdPart(
      id: id ?? this.id,
      idbusiness: idbusiness ?? this.idbusiness,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      thirdPartType: thirdPartType ?? this.thirdPartType,
      name: name ?? this.name,
      country: country ?? this.country,
      city: city ?? this.city,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      instagram: instagram ?? this.instagram,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// 🔹 Conversión desde JSON
  factory ThirdPart.fromJson(Map<String, dynamic> json) {
    return ThirdPart(
      id: json['id'] as String,
      idbusiness: json['idbusiness'] as String?,
      documentType: json['documentType'] as String?,
      documentNumber: json['documentNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      thirdPartType: json['thirdPartType'] as String?,
      name: json['name'] as String,
      country: json['country'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      instagram: json['instagram'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  /// 🔹 Conversión a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idbusiness': idbusiness,
      'documentType': documentType,
      'documentNumber': documentNumber,
      'imageUrl': imageUrl,
      'thirdPartType': thirdPartType,
      'name': name,
      'country': country,
      'city': city,
      'address': address,
      'phone': phone,
      'email': email,
      'instagram': instagram,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// 🔹 Conversión desde Map (ej. BD)
  factory ThirdPart.fromMap(Map<String, dynamic> map) {
    return ThirdPart(
      id: map['id'] as String,
      idbusiness: map['idbusiness'] as String?,
      documentType: map['documentType'] as String?,
      documentNumber: map['documentNumber'] as String?,
      imageUrl: map['imageUrl'] as String?,
      thirdPartType: map['thirdPartType'] as String?,
      name: map['name'] as String,
      country: map['country'] as String?,
      city: map['city'] as String?,
      address: map['address'] as String?,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      instagram: map['instagram'] as String?,
      notes: map['notes'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.tryParse(map['updatedAt'])
          : null,
    );
  }

  /// 🔹 Conversión a Map (ej. BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idbusiness': idbusiness,
      'documentType': documentType,
      'documentNumber': documentNumber,
      'imageUrl': imageUrl,
      'thirdPartType': thirdPartType,
      'name': name,
      'country': country,
      'city': city,
      'address': address,
      'phone': phone,
      'email': email,
      'instagram': instagram,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ThirdPart(id: $id, name: $name, email: $email, imageUrl: $imageUrl, type: $thirdPartType)';
  }
}
