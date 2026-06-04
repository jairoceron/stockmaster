import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

/// Inicializa el cliente GraphQL con soporte para queries y suscripciones.
/// Usa el IdToken de Cognito para autenticación en HttpLink y WebSocketLink.
Future<ValueNotifier<GraphQLClient>> initGraphQLClient() async {
  // Obtén el token de Cognito
  final session = await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
  final tokens = session.userPoolTokensResult.value;
  final idToken = tokens.idToken.raw;

  debugPrint("🔑 GraphQLClient inicializado con IdToken");
  debugPrint(">>> AccessToken: ${tokens.accessToken.raw}");
  debugPrint(">>> IdToken: $idToken");

  // HttpLink con el token dinámico
  final httpLink = HttpLink(
    'https://vcb5i4iozffm5odzta6fywbarq.appsync-api.us-east-2.amazonaws.com/graphql',
    defaultHeaders: {
      'Authorization': idToken,
    },
  );

  // WebSocketLink con el mismo token
  final websocketLink = WebSocketLink(
    'wss://vcb5i4iozffm5odzta6fywbarq.appsync-realtime-api.us-east-2.amazonaws.com/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(minutes: 5),
      delayBetweenReconnectionAttempts: const Duration(seconds: 5),
      initialPayload: () async {
        final session = await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
        final tokens = session.userPoolTokensResult.value;
        final idTokenWs = tokens.idToken.raw;
        debugPrint("WS Authorization token_use=id: $idTokenWs");
        return {
          'Authorization': idTokenWs,
        };
      },
    ),
  );


  debugPrint("\n\n\n 002 WebSocketLink(  ${websocketLink.url} \n\n\n");


  // Combina ambos links: Http para queries/mutations, WS para suscripciones
  final link = Link.split(
        (request) => request.isSubscription,
    websocketLink,
    httpLink,
  );

  // Crea el cliente con cache persistente
  final client = GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: link,
  );

  debugPrint("\n\n\n\n  graphql_client.dart ...... sesion XXXXXXXXXXXX \n\n\n\n");

  return ValueNotifier(client);
}
