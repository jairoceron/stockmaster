import 'package:drift/drift.dart';
import 'package:stockmaster/data/database/local/app_database.dart';
import 'package:stockmaster/data/database/local/businesss.dart';
import 'package:stockmaster/models/business.dart';

extension BusinessMapper on Business {
  /// Convierte un modelo de dominio Business a un Companion para INSERT
  BusinesssCompanion toInsertCompanion() {
    return BusinesssCompanion.insert(
      idbusiness: idbusiness! ,
      name: name == null ? const Value.absent() : Value<String>(name!),
      website: website == null ? const Value.absent() : Value<String>(website!),
      email: email == null ? const Value.absent() : Value<String>(email!),
      direccion: direccion == null ? const Value.absent() : Value<String>(direccion!),
      pais: pais == null ? const Value.absent() : Value<String>(pais!),
      ciudad: ciudad == null ? const Value.absent() : Value<String>(ciudad!),
      latitud: latitud == null ? const Value.absent() : Value<String>(latitud!),
      longitud: longitud == null ? const Value.absent() : Value<String>(longitud!),
      acteconomica: acteconomica == null ? const Value.absent() : Value<String>(acteconomica!),
      celular: celular == null ? const Value.absent() : Value<String>(celular!),
      createdat: createdat == null ? const Value.absent() : Value<DateTime>(createdat!),
    );
  }

  /// Convierte un modelo de dominio Business a un Companion para UPDATE
  BusinesssCompanion toUpdateCompanion() {
    return BusinesssCompanion(
      idbusiness: idbusiness == null ? const Value.absent() : Value<String>(idbusiness!), // obligatorio para update
      name: name == null ? const Value.absent() : Value<String>(name!),
      website: website == null ? const Value.absent() : Value<String>(website!),
      email: email == null ? const Value.absent() : Value<String>(email!),
      direccion: direccion == null ? const Value.absent() : Value<String>(direccion!),
      pais: pais == null ? const Value.absent() : Value<String>(pais!),
      ciudad: ciudad == null ? const Value.absent() : Value<String>(ciudad!),
      latitud: latitud == null ? const Value.absent() : Value<String>(latitud!),
      longitud: longitud == null ? const Value.absent() : Value<String>(longitud!),
      acteconomica: acteconomica == null ? const Value.absent() : Value<String>(acteconomica!),
      celular: celular == null ? const Value.absent() : Value<String>(celular!),
      createdat: createdat == null ? const Value.absent() : Value<DateTime>(createdat!),
    );
  }

  /// Convierte un modelo de dominio Business a una entidad Drift BusinessEntity
  BusinessEntity toEntity() {
    return BusinessEntity(
      idbusiness: idbusiness!,
      name: name,
      website: website,
      email: email,
      direccion: direccion,
      pais: pais,
      ciudad: ciudad,
      latitud: latitud,
      longitud: longitud,
      acteconomica: acteconomica,
      celular: celular,
      createdat: createdat! ,

    );
  }

  /// Convierte una entidad Drift BusinessEntity a un modelo de dominio Business
  static Business fromEntity(BusinessEntity entity) {
    return Business(
      idbusiness: entity.idbusiness,
      name: entity.name,
      website: entity.website,
      email: entity.email,
      direccion: entity.direccion,
      pais: entity.pais,
      ciudad: entity.ciudad,
      latitud: entity.latitud,
      longitud: entity.longitud,
      acteconomica: entity.acteconomica,
      celular: entity.celular,
      createdat: entity.createdat,
    );
  }
}
