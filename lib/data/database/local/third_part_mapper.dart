import 'package:stockmaster/data/database/local/app_database.dart';

import '/data/database/local/third_parts.dart'; // contiene ThirdPartEntity
import '/models/third_part.dart'; // tu modelo

extension ThirdPartEntityMapper on ThirdPartEntity {
  ThirdPart toModel() {
    return ThirdPart(
      id: id,
      idbusiness: idbusiness,
      documentType: documentType,
      documentNumber: documentNumber,
      imageUrl: imageUrl,
      thirdPartType: thirdPartType,
      name: name,
      country: country,
      city: city,
      address: address,
      phone: phone,
      email: email,
      instagram: instagram,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension ThirdPartMapper on ThirdPart {
  ThirdPartEntity toEntity() {
    return ThirdPartEntity(
      id: id,
      idbusiness: idbusiness,
      documentType: documentType,
      documentNumber: documentNumber,
      imageUrl: imageUrl,
      thirdPartType: thirdPartType,
      name: name,
      country: country,
      city: city,
      address: address,
      phone: phone,
      email: email,
      instagram: instagram,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
