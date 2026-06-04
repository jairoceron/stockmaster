import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../data/database/local/app_database.dart';
import '../data/repositories/sqlite_product_service.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

import '../screens/bottom_navigation_bar.dart';
import '../screens/guest_screen.dart';
import '../state/inventory_notifier.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final AuthService _authService = AuthService();
  bool _loading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    debugPrint("\n\n ✅ root_screen.dart RootScreen initState() \n\n");

    Future.microtask(() {
      final notifier = Provider.of<InventoryNotifier>(context, listen: false);
      debugPrint('\n root_screen.dart ... future.Microtask ... step 001 ');
      notifier.loadProducts(); // ✅ ahora sí notifica a la UI
    });



    // ✅ Diferimos la inicialización para evitar notifyListeners durante build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).setGuestUser();

      _checkSession();
    });
  }

  Future<void> _checkSession() async {
    final loggedIn = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = loggedIn;
      _loading = false;
    });

    if (loggedIn) {
      debugPrint("\n\n ✅ RootScreen _checkSession() usuario logueado \n\n");

      final attributes = await Amplify.Auth.fetchUserAttributes();
      String username = '';
      String phone = '';
      String idbusiness = '1';


      int idrol = 0;
      String platform = "";
      String deviceId = "";

      for (final attr in attributes) {
        if (attr.userAttributeKey.key == 'email') {
          username = attr.value;
        }
        if (attr.userAttributeKey.key == 'phone_number') {
          phone = attr.value;
        }
        if (attr.userAttributeKey.key == 'custom:tenantid') {
          idbusiness = attr.value ?? '1';
          debugPrint("\n\n ✅ !!!!!!! toca con calma !!!! ::  attr.value \n\n");
          debugPrint("\n\n ✅ !!!!!!! este marica ya está logeado, por eso es que sale el $idbusiness \n\n");
        }
        if (attr.userAttributeKey.key == 'custom:idrol') {
          idrol = int.tryParse(attr.value) ?? 0;
        }
        if (attr.userAttributeKey.key == 'custom:deviceId') {
          deviceId = attr.value;
        }
        if (attr.userAttributeKey.key == 'custom:platform') {
          platform = attr.value;
        }
      }

      final appUser = AppUser(
        username: username,
        phone: phone,

        idrol: idrol,
        deviceId: deviceId,
        platform: platform,
        id : 0,
        tenantid : idbusiness,
        name : '',
        email : '',
        direccion : '',
        pais : '',
        ciudad : '',
        celular : '',
        createdAt :  DateTime.now(),
      );

      Provider.of<UserProvider>(context, listen: false).setUser(appUser);
    } else {
      debugPrint("\n\n ✅ RootScreen _checkSession() usuario invitado \n\n");
      Provider.of<UserProvider>(context, listen: false).setGuestUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final userProvider = Provider.of<UserProvider>(context);

    // ✅ Decide automáticamente según estado
    if (userProvider.isGuest) {
      return const GuestScreen();
    } else {
      return const BottomNavBar();
    }
  }
}
