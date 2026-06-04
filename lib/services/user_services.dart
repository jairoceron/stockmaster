import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/user.dart';

class UserService {
  /// Recupera los atributos del usuario autenticado en Cognito
  ///
  /*
  static Future<AppUser> fetchCurrentUser() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();

      String? email;
      String? phone;
      int idbusiness = 0;
      int idrol = 1;
      String deviceId = "";
      String platform = "";

      for (var attr in attributes) {
        switch (attr.userAttributeKey.key) {
          case 'email':
            email = attr.value;
            break;
          case 'phone_number':
            phone = attr.value;
            break;
          case 'custom:idbusiness':
            idbusiness = int.tryParse(attr.value) ?? 0;
            break;
          case 'custom:idrol':
            idrol = int.tryParse(attr.value) ?? 0;
            break;
        }
      }

      return AppUser(
        username: email ?? '',
        phone: phone ?? '',
        idbusiness: idbusiness,
        idrol:idrol,
        deviceId : deviceId,
        platform : platform,
      );
    } catch (e) {
      safePrint("Error fetching user attributes: $e");
      // Devuelve un AppUser vacío en caso de error
      return AppUser(username: '', phone: '', idbusiness: 0, idrol:1,deviceId : '',
        platform : '',  );
    }
  }
  */
}