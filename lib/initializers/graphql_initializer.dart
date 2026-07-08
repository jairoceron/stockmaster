import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLInitializer {
  static ValueNotifier<GraphQLClient> initClient() {
    return ValueNotifier(
      GraphQLClient(
        link: HttpLink("https://.../graphql"),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}
