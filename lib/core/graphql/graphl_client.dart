// lib/core/graphql/graphql_client.dart
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
// lib/core/graphql/graphql_service.dart


class GraphQLService {
  final CognitoUserPool userPool;

  GraphQLService(this.userPool);

  Future<GraphQLClient> initClient(String username, String password) async {
    await initHiveForFlutter();

    // Authenticate user against Cognito
    final cognitoUser = CognitoUser(username, userPool);
    final authDetails = AuthenticationDetails(
      username: username,
      password: password,
    );
    final session = await cognitoUser.authenticateUser(authDetails);
    if (session == null) {
      throw Exception("Authentication failed, no session returned");
    }
    final token = session.getAccessToken().getJwtToken();

    if (token == null) {
      throw Exception("Authentication failed: no token available");
    }


    final HttpLink httpLink = HttpLink(
      'https://vcb5i4iozffm5odzta6fywbarq.appsync-api.us-east-2.amazonaws.com/graphql',
      defaultHeaders: {
        'Authorization': token,
      },
    );

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    );
  }
}
