import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';

import '../data/database/local/app_database.dart';
import '../providers/user_provider.dart';



class InicializationCompany {
  final AppDatabase db;
  final UserProvider userProvider;

  InicializationCompany({
    required this.db,
    required this.userProvider,
  });

  Future<void> initSession() async {
    // Query the Businesss table
    final businesses = await db.select(db.businesss).get();
    final uuid = const Uuid().v4();


    debugPrint("\n\n\n userProvider 0001   \n\n\n");

    if (businesses.isEmpty) {


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
      );

      debugPrint("\n\n\n userProvider 0001  entity  $entity  \n\n\n");
      await db.into(db.businesss).insert(entity);

      // ✅ Asignar tenantId al UserProvider
      // userProvider.setTenantId(uuid);


    } else {
      final record = businesses.first;
      userProvider.setTenantId(record.idbusiness);
      debugPrint("\n\n\n userProvider a1 0001  record  $record  \n\n\n");
      debugPrint("\n\n\n userProvider a2 0002  record  ${record.idbusiness}  \n\n\n");
    }


    debugPrint("\n\n\n userProvider a3 ${userProvider} ------------  ${userProvider.user}  \n\n\n");
    debugPrint("\n\n\n userProvider a4 >>>>>>>>>>>>>>>> $userProvider   \n\n\n");
  }
}
