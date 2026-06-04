import 'dart:convert';

class ClientAttribute {
  final int? id;              // PK autoincremental
  final String? uuid;         // UUID opcional para sincronización
  final String clientType;    // Tipo de cliente (ej. carnicería)
  final String fieldName;     // Nombre del campo (ej. proveedor)
  final String fieldType;     // Tipo de dato (text, number, date)
  final bool isRequired;      // Si es obligatorio
  final int? displayOrder;    // Orden de aparición

  ClientAttribute({
    this.id,
    this.uuid,
    required this.clientType,
    required this.fieldName,
    required this.fieldType,
    this.isRequired = false,
    this.displayOrder,
  });

  ClientAttribute copyWith({
    int? id,
    String? uuid,
    String? clientType,
    String? fieldName,
    String? fieldType,
    bool? isRequired,
    int? displayOrder,
  }) {
    return ClientAttribute(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      clientType: clientType ?? this.clientType,
      fieldName: fieldName ?? this.fieldName,
      fieldType: fieldType ?? this.fieldType,
      isRequired: isRequired ?? this.isRequired,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  factory ClientAttribute.fromJson(Map<String, dynamic> json) {
    return ClientAttribute(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      uuid: json['uuid']?.toString(),
      clientType: json['clientType']?.toString() ?? '',
      fieldName: json['fieldName']?.toString() ?? '',
      fieldType: json['fieldType']?.toString() ?? '',
      isRequired: json['isRequired'] == true || json['isRequired'] == 1,
      displayOrder: json['displayOrder'] != null
          ? int.tryParse(json['displayOrder'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'clientType': clientType,
      'fieldName': fieldName,
      'fieldType': fieldType,
      'isRequired': isRequired,
      'displayOrder': displayOrder,
    };
  }

  factory ClientAttribute.fromMap(Map<String, dynamic> map) {
    return ClientAttribute(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      clientType: map['clientType'] as String,
      fieldName: map['fieldName'] as String,
      fieldType: map['fieldType'] as String,
      isRequired: map['isRequired'] == true || map['isRequired'] == 1,
      displayOrder: map['displayOrder'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'clientType': clientType,
      'fieldName': fieldName,
      'fieldType': fieldType,
      'isRequired': isRequired,
      'displayOrder': displayOrder,
    };
  }

  @override
  String toString() {
    return 'ClientAttribute(id: $id, uuid: $uuid, clientType: $clientType, '
        'fieldName: $fieldName, fieldType: $fieldType, '
        'isRequired: $isRequired, displayOrder: $displayOrder)';
  }
}
