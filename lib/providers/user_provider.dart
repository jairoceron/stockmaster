import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import '../data/database/local/business_dao.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

class UserProvider extends ChangeNotifier {


  AppUser _user = AppUser.guest(
    "guest",
  ); // ✅ siempre inicializado como invitado
  final AuthService _authService = AuthService();

  AppUser get user => _user;

  // ✅ Método para asignar tenantId
  void setTenantId(String tenantId) {
    _user = _user.copyWith(tenantid: tenantId);
    notifyListeners();
  }

  bool get isLoggedIn => !_user.isGuest;
  bool get isGuest => _user.isGuest;

  void setUser(AppUser user) {
    _user = user;
    notifyListeners();
  }

  void setGuestUser() {
    _user = AppUser.guest("guest");
    notifyListeners();
  }

  void clearUser() {
    setGuestUser(); // ✅ nunca queda en null
  }

  Future<void> checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();

    if (!loggedIn) {
      setGuestUser();
    } else {
      final attributes = await Amplify.Auth.fetchUserAttributes();

      String username = '';
      String phone = '';
      String tenantid = const Uuid().v4();
      int idrol = 0;

      debugPrint("\n\n si pasa por acá este es el tenand::  $tenantid     \n\n");

      for (final attr in attributes) {
        if (attr.userAttributeKey.key == 'email') {
          username = attr.value;
        }
        if (attr.userAttributeKey.key == 'phone_number') {
          phone = attr.value;
        }
        if (attr.userAttributeKey.key == 'custom:tenantid') {
          tenantid = attr.value;
          debugPrint("\n\n este es el tenand::  $tenantid     \n\n");
        }
        if (attr.userAttributeKey.key == 'custom:idrol') {
          idrol = int.tryParse(attr.value) ?? 0;
        }
      }

      final info = await getDeviceInfo();
      final deviceId = info['deviceId'] ?? "";
      final platform = info['platform'] ?? "";

      final appUser = AppUser(
        username: username,
        phone: phone,
        tenantid: tenantid,
        idrol: idrol,
        deviceId: deviceId,
        platform: platform,
        id: 0,

        name: '',
        email: username,
        direccion: '',
        pais: '',
        ciudad: '',
        celular: phone,
        createdAt: DateTime.now(),
      );

      setUser(appUser);
    }
  }

  Future<void> login(String email, String password) async {
    final result = await _authService.signIn(email: email, password: password);

    final info = await getDeviceInfo();
    final deviceId = info['deviceId'] ?? "";
    final platform = info['platform'] ?? "";

    if (result.isSignedIn) {
      final attributes = await Amplify.Auth.fetchUserAttributes();

      String username = email;
      String phone = '';
      String idbusiness = '1';
      int idrol = 0;

      debugPrint("\n\n   Future<void> login( si pasa por acá este es el tenand::  $idbusiness     \n\n");

      for (final attr in attributes) {
        if (attr.userAttributeKey.key == 'phone_number') {
          phone = attr.value;
        }
        if (attr.userAttributeKey.key == 'custom:idbusiness') {
          debugPrint("\n\n user_provider.dart ....... tenandid  11111111111111111111111111111111111111111     \n\n");
          idbusiness = attr.value.isNotEmpty ? attr.value : '1';



          if (idbusiness != null) {
            debugPrint("Primer idbusiness encontrado: $idbusiness");
          } else {
            debugPrint("No hay registros en la tabla businesss");
          }


        }
        if (attr.userAttributeKey.key == 'custom:idrol') {
          idrol = int.tryParse(attr.value) ?? 0;
        }
      }


      debugPrint("\n\n user_provider.dart ....... tenandid  !!!!!!!!!!!!!!!!!!   111111111111111  $idbusiness   \n\n");

      final appUser = AppUser(
        username: username,
        phone: phone,

        idrol: idrol,
        deviceId: deviceId,
        platform: platform,
        id: 0,
        tenantid: idbusiness, // 🔹 tenantid alineado con idbusiness
        name: '',
        email: username,
        direccion: '',
        pais: '',
        ciudad: '',
        celular: phone,
        createdAt: DateTime.now(),
      );

      setUser(appUser);
    } else {
      setGuestUser();
    }




  }

  Future<void> logout() async {
    await _authService.signOut();
    setGuestUser();
  }

  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId = "";
    String platform = "";

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      platform = "Android";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "unknown";
      platform = "iOS";
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfo.windowsInfo;
      deviceId = windowsInfo.deviceId;
      platform = "Windows";
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfo.linuxInfo;
      deviceId = linuxInfo.machineId ?? "unknown";
      platform = "Linux";
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      deviceId = macInfo.systemGUID ?? "unknown";
      platform = "macOS";
    } else {
      deviceId = "unknown";
      platform = "unknown";
    }

    return {"deviceId": deviceId, "platform": platform};
  }

  @override
  String toString() {
    return '''
UserProvider(
  isLoggedIn: $isLoggedIn,
  isGuest: $isGuest,
  user: ${_user.toString()}
)
''';
  }
}
