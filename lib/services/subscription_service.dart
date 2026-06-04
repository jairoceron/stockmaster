import 'dart:async';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:stockmaster/state/inventory_notifier.dart';
import '/graphql/product_queries.dart';
import '../constants/app_constants.dart';
import '../models/product.dart';
import '../providers/user_provider.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'dart:convert';



class SubscriptionService {
  final UserProvider userProvider;
  final InventoryNotifier inventoryNotifier;

  SubscriptionService({
    required this.userProvider,
    required this.inventoryNotifier,
  });

  bool _isSubscribed = false;
  StreamSubscription<QueryResult>? _subscription;

  Future<void> initSubscription() async {
    final appUser = userProvider.user;

    try {
      final session =
      await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
      if (!session.isSignedIn) {
        debugPrint("❌ Usuario no autenticado, no se suscribe.");
        return;
      }

      if (_isSubscribed) {
        debugPrint("⚠️ Ya existe una suscripción activa.");
        return;
      }

      final idToken = session.userPoolTokensResult.value.idToken.raw;

      final httpLink = HttpLink(
        AppConstants.GraphQL_endpoint,
        defaultHeaders: {'Authorization': idToken},
      );

      final websocketLink = WebSocketLink(
        AppConstants.real_time_endpoint,
        config: SocketClientConfig(
          autoReconnect: true,
          initialPayload: () async {
            final payload = {
              "authorization": idToken, // ✅ minúscula
            };
            print(">>> Payload enviado: $payload");
            return payload;
          },
        ),
      );

      final link = Link.split(
            (request) => request.isSubscription,
        websocketLink,
        httpLink,
      );

      final client = GraphQLClient(cache: GraphQLCache(), link: link);

      final subscriptionQuery = gql(r'''
        subscription OnAddProduct($idbusiness: String!) {
          onAddProduct(idbusiness: $idbusiness) {
            id
            idbusiness
            idcategory
            name
            stock
            price
          }
        }
      ''');

      _subscription = client
          .subscribe(
        SubscriptionOptions(
          document: subscriptionQuery,
          variables: {"idbusiness": appUser.tenantid}, // ✅ variable real
        ),
      )
          .listen((result) {
        if (result.hasException) {
          debugPrint("❌ Error en suscripción: ${result.exception}");
        } else {
          debugPrint("📦 Evento recibido: ${result.data}");
          final productJson = result.data?['onAddProduct'];
          if (productJson != null) {
            inventoryNotifier.addProduct(Product.fromJson(productJson));
          }
        }
      });

      debugPrint("✅ Suscripción creada correctamente con tenant ${appUser.tenantid}");
      _isSubscribed = true;
    } catch (e) {
      debugPrint("❌ Error al inicializar suscripción: $e");
    }
  }

  void dispose() {
    _subscription?.cancel();
    _isSubscribed = false;
  }
}
