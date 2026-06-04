import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/database/graphql/graphql_client.dart';
import '../data/report/repositories/report_repository_impl.dart';
import '../providers/inventory_provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';
import '../screens/bottom_navigation_bar.dart';
import '../services/auth_service.dart';
import '../services/user_services.dart';
import '/presentation/report/report_controller.dart';

class LoginController {
  final AuthService authService;

  LoginController(this.authService);

  Future<void> signIn(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController,
      ) async {
    try {

      final signedIn = await authService.isSignedIn();
      if (signedIn) {
        await _onLoginSuccess(context);
      } else {
        final result = await authService.signIn(
          email: emailController.text,
          password: passwordController.text,
        );
        if (result.isSignedIn) {
          await _onLoginSuccess(context);
        } else {
          if (result.nextStep?.signInStep ==
              AuthSignInStep.confirmSignInWithNewPassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Debes cambiar la contraseña')),
            );
          }
        }
      }
    } on AuthException catch (e) {
      debugPrint("❌ AuthException: ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de autenticación: ${e.message}')),
      );
    } catch (e) {
      debugPrint("⚠️ Error desconocido: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error en login: $e')),
      );
    }
  }

  Future<void> _onLoginSuccess(BuildContext context) async {
    // Obtén el usuario actual desde Cognito
  //  final appUser = await UserService.fetchCurrentUser();
  //  Provider.of<UserProvider>(context, listen: false).setUser(appUser);

    // Inicializa el cliente GraphQL con token de Cognito
    final clientNotifier = await initGraphQLClient();
    final client = clientNotifier.value;

    // Actualiza el contexto de negocio en ReportController
    final reportRepository = ReportRepositoryImpl(
      baseUrl:
      "https://vcb5i4iozffm5odzta6fywbarq.appsync-api.us-east-2.amazonaws.com/graphql",
    );
    final reportController =
    Provider.of<ReportController>(context, listen: false);
   // reportController.updateBusinessContext(reportRepository, appUser.idbusiness);

    // 👉 Ejecuta query inicial y arranca la suscripción en ReportController
   // await reportController.fetchInitialSummary(client);
  //  reportController.startSubscription(client);

    // 👉 Engancha el InventoryProvider ya existente
 //   final inventoryProvider =
  //  Provider.of<InventoryProvider>(context, listen: false);
 //   inventoryProvider.startSubscription(appUser.idbusiness);

    // Navega a la pantalla principal con GraphQLProvider
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => GraphQLProvider(
          client: clientNotifier,
          child: const BottomNavBar(),
        ),
      ),
    );
  }
}
