import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:stockmaster/data/database/local/business_dao.dart';
import 'package:stockmaster/providers/inventory_type_provider.dart';
import 'package:stockmaster/services/inventory_type_sync_service.dart';
import 'package:uuid/uuid.dart';

import '../data/database/local/app_database.dart';
import '../providers/BusinessProvider.dart';
import '../providers/user_provider.dart';


class InicializationCompany {
  final AppDatabase db;
  final UserProvider userProvider;
  final BusinessProvider businessProvider;
  final InventoryTypeProvider inventoryTypeProvider;
  final BusinessDao businessDao;

  InicializationCompany({
    required this.db,
    required this.userProvider,
    required this.businessProvider,
    required this.inventoryTypeProvider,
    required this.businessDao,
  });

  Future<void> initSession() async {
    // Consultar la tabla Businesss
    final businesses = await db.select(db.businesss).get();
    final uuid = const Uuid().v4();

    debugPrint("\n\n InicializationCompany: inicio de sesión \n\n");

    if (businesses.isEmpty) {
      // Crear registro por defecto
      final entity = BusinesssCompanion.insert(
        idbusiness: uuid,
        name: const Value('Test Company'),
        website: const Value('www.testcompany.com'),
        email: const Value('test@testcompany.com'),
        direccion: const Value('123 Test St'),
        pais: const Value('Testland'),
        ciudad: const Value('Testville'),
        latitud: const Value('0.0000'),
        longitud: const Value('0.0000'),
        acteconomica: const Value('Retail'),
        celular: const Value('1234567890'),
        typeinventory: const Value('Droguería / Naturistas'), // 👈 valor por defecto
      );

      await db.into(db.businesss).insert(entity);

      // Actualizar UserProvider con el tenantId
      userProvider.setTenantId(uuid);

      // Crear entidad BusinessEntity para BusinessProvider
      final newBusiness = BusinessEntity(
        idbusiness: uuid,
        name: 'Test Company',
        website: 'www.testcompany.com',
        email: 'test@testcompany.com',
        direccion: '123 Test St',
        pais: 'Testland',
        ciudad: 'Testville',
        latitud: '0.0000',
        longitud: '0.0000',
        acteconomica: 'Retail',
        celular: '1234567890',
        typeinventory: 'Droguería / Naturistas',
        createdat: DateTime.now(), // 👈 fecha actual
      );

      businessProvider.setBusiness(newBusiness);

      debugPrint("\n\n Business creado y cargado en BusinessProvider: $newBusiness \n\n");
    } else {
      // Usar el primer registro existente
      final record = businesses.first;

      // Actualizar UserProvider con el tenantId
      userProvider.setTenantId(record.idbusiness);

      // Actualizar BusinessProvider con el registro existente
      businessProvider.setBusiness(record);

      debugPrint("\n\n Business existente cargado en BusinessProvider: $record \n\n");
    }
    // 👇 Aquí invocas el servicio para sincronizar el InventoryTypeProvider

    // lógica de inicialización...
    final business = await businessDao.getFirstBusiness();
    if (business != null && business.typeinventory != null) {
      inventoryTypeProvider.setInventoryType(business.typeinventory!);
      debugPrint("\n\n !!!!!!!!!!! carga el inventoryTypeProvider $business ");

    }  else {
      debugPrint("\n\n no carga el inventoryTypeProvider $business ");
    }
    // inventoryTypeProvider.setInventoryType(business.typeinventory);

    debugPrint("\n\n UserProvider tenantId: ${userProvider.user?.tenantid} \n\n");
    debugPrint("\n\n BusinessProvider business: ${businessProvider.business} \n\n");
  }


}
