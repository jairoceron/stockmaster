import 'dart:convert';
import 'package:drift/drift.dart';
import '../data/database/local/app_database.dart';
import '../data/database/local/businesss.dart';

class Business {
  final String? idbusiness;
  final String? name;
  final String? website;
  final String? email;
  final String? direccion;
  final String? pais;
  final String? ciudad;
  final String? latitud;
  final String? longitud;
  final String? acteconomica;
  final String? celular;
  final DateTime? createdat;

  Business({
    this.idbusiness,
    this.name,
    this.website,
    this.email,
    this.direccion,
    this.pais,
    this.ciudad,
    this.latitud,
    this.longitud,
    this.acteconomica,
    this.celular,
    this.createdat,
  });

  Business copyWith({
    String? idbusiness,
    String? name,
    String? website,
    String? email,
    String? direccion,
    String? pais,
    String? ciudad,
    String? latitud,
    String? longitud,
    String? acteconomica,
    String? celular,
    DateTime? createdat,
  }) {
    return Business(
      idbusiness: idbusiness ?? this.idbusiness,
      name: name ?? this.name,
      website: website ?? this.website,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      acteconomica: acteconomica ?? this.acteconomica,
      celular: celular ?? this.celular,
      createdat: createdat ?? this.createdat,
    );
  }

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      idbusiness: json['idbusiness'] as String?,
      name: json['name'] as String?,
      website: json['website'] as String?,
      email: json['email'] as String?,
      direccion: json['direccion'] as String?,
      pais: json['pais'] as String?,
      ciudad: json['ciudad'] as String?,
      latitud: json['latitud'] as String?,
      longitud: json['longitud'] as String?,
      acteconomica: json['acteconomica'] as String?,
      celular: json['celular'] as String?,
      createdat: json['createdat'] != null
          ? DateTime.tryParse(json['createdat'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idbusiness': idbusiness,
      'name': name,
      'website': website,
      'email': email,
      'direccion': direccion,
      'pais': pais,
      'ciudad': ciudad,
      'latitud': latitud,
      'longitud': longitud,
      'acteconomica': acteconomica,
      'celular': celular,
      'createdat': createdat?.toIso8601String(),
    };
  }

  factory Business.fromEntity(BusinessEntity entity) {
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

  BusinesssCompanion toCompanion() {
    return BusinesssCompanion(
      idbusiness: idbusiness == null
          ? const Value.absent()
          : Value<String>(idbusiness!),   // 👈 fuerza tipo String
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
      createdat: createdat == null
          ? const Value.absent()
          : Value<DateTime>(createdat!), // 👈 fuerza tipo DateTime
    );
  }
}
