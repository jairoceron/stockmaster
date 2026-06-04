import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../constants/app_constants.dart';

class GraphQLService {
  // Singleton
  static final GraphQLService _instance = GraphQLService._internal();
  factory GraphQLService() => _instance;
  GraphQLService._internal();

  GraphQLClient? _client;

  Future<GraphQLClient> getClient() async {
    if (_client != null) return _client!;

    // 1. Verificar sesión Cognito
    final session = await Amplify.Auth.fetchAuthSession() as CognitoAuthSession;
    if (!session.isSignedIn) {
      throw Exception("Usuario no autenticado");
    }

    // 2. Obtener token
    final idToken = session.userPoolTokensResult.value.idToken.raw;

    // 3. Configurar links
    final httpLink = HttpLink(
      AppConstants.GraphQL_endpoint,
      defaultHeaders: {'Authorization': idToken},
    );

    final websocketLink = WebSocketLink(
      AppConstants.real_time_endpoint,
      config: SocketClientConfig(
        autoReconnect: true,
        initialPayload: () async => {'Authorization': idToken},
      ),
    );

    debugPrint("\n\n 000003 GraphQLService Future<GraphQLClient> getClient() WebSocketLink( ... ${websocketLink.url}  003     \n\n");


    final link = Link.split((request) => request.isSubscription, websocketLink, httpLink);

    // 4. Crear cliente
    _client = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: link,
    );

    return _client!;
  }
}
