import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/foundation.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';




class AuthService {

  final userPool = CognitoUserPool(
    'us-east-2_hmAJLG57u',
    '3u2geb3kga0q448jk9a728nksl',
  );

  /// Verifica si hay sesión activa
  Future<bool> isSignedIn() async {

    debugPrint("\n\n XXX AuthService  isSignedIn() \n\n");


    final session = await Amplify.Auth.fetchAuthSession();
    debugPrint("\n\n XXX AuthService  isSignedIn() session $session   session.isSignedIn  ${session.isSignedIn}\n\n");
    return session.isSignedIn;
  }

  /// Nuevo método: alias más semántico
  Future<bool> isLoggedIn() async {
    try {
      final user = await Amplify.Auth.getCurrentUser();
      return user != null; // ✅ Solo true si hay usuario activo
    } catch (_) {
      return false; // ✅ Si no hay sesión, devuelve false
    }
  }

  Future<SignInResult> signIn({
    required String email,
    required String password,
  }) async {
    return await Amplify.Auth.signIn(
      username: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }

  Future<void> signUp({
    required String email,
    required String password,
    int? businessId,
    int? idRol,
  }) async {
    final userAttributes = [
      AttributeArg(name: 'email', value: email),
      if (businessId != null)
        AttributeArg(name: 'custom:idbusiness', value: businessId.toString()),
      if (idRol != null)
        AttributeArg(name: 'custom:idrol', value: idRol.toString()),
    ];

    await userPool.signUp(email, password, userAttributes: userAttributes);
  }


  Future<void> confirmSignUp({
    required String email,
    required String code,
  }) async {
    await Amplify.Auth.confirmSignUp(
      username: email,
      confirmationCode: code,
    );
  }

  /// 🔄 Reenviar código de confirmación
  Future<void> resendConfirmationCode(String email) async {
    await Amplify.Auth.resendSignUpCode(username: email);
  }
}
