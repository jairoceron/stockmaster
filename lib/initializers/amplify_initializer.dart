import 'package:amplify_flutter/amplify_flutter.dart';

class AmplifyInitializer {
  static Future<void> configure() async {
    await Amplify.configure('{}'); // tu configuración real
  }
}