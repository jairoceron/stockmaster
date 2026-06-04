import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'dart:convert';
import '../../amplifyconfiguration.dart';

class AmplifyInitializer {
  static Future<void> configure() async {
    try {
      final authPlugin = AmplifyAuthCognito();
      final apiPlugin = AmplifyAPI();
      await Amplify.addPlugins([authPlugin, apiPlugin]);

      jsonDecode(amplifyconfig);
      await Amplify.configure(amplifyconfig);
      safePrint('✅ Amplify configured correctly');
    } catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }
}
