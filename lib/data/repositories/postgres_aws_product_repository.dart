// 3. Implementación remota con GraphQL
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stockmaster/data/repositories/product_repository.dart';
import '/graphql/product_queries.dart';
import '../../models/product.dart';
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../models/product.dart';
import 'product_repository.dart';

import 'package:flutter/foundation.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/inventory_provider.dart';
import '../../providers/user_provider.dart';

class PostgresAWSProductRepository implements ProductRepository {
  final GraphQLClient client;

  PostgresAWSProductRepository(this.client);

  @override
  Future<List<Product>> getAll(int idbusiness, int limit, int offset) async {
    final result = await client.query(
      QueryOptions(document: gql(getProductsQuery)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data;
    if (data == null || data['products'] == null) {
      return [];
    }

    return (data['products'] as List)
        .map((r) => Product.fromMap(r as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final result = await client.query(
      QueryOptions(document: gql(getProductsQuery)),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data;
    if (data == null || data['products'] == null) {
      return [];
    }

    return (data['products'] as List)
        .map((r) => Product.fromMap(r as Map<String, dynamic>))
        .toList();
  }

  Future<Product> add(Product product) async {
    debugPrint(
      "postgres_aws_product_repository.dart $product ------------ !!!!!!! ",
    );
    final result = await client.mutate(
      MutationOptions(
        document: gql(r'''mutation CreateProduct(
  $id: ID!,
  $name: String!,
  $stock: Int!,
  $price: Float!,
  $idbusiness: String!,
  $idcategory: String,
  $image: String,
  $createdat: AWSDateTime,
  $owner: String,
  $barcode: String,
  $stockminimumlevel: Int,
  $deviceid: String,
  $platform: String,
  $ubicacion: String,
  $bodega: String,
  $syncstatus: Boolean,
  $lastsyncedat: AWSDateTime,
  $syncstate: String
) {
  createProduct(
    id: $id,
    name: $name,
    stock: $stock,
    price: $price,
    idbusiness: $idbusiness,
    idcategory: $idcategory,
    image: $image,
    createdat: $createdat,
    owner: $owner,
    barcode: $barcode,
    stockminimumlevel: $stockminimumlevel,
    deviceid: $deviceid,
    platform: $platform,
    ubicacion: $ubicacion,
    bodega: $bodega,
    syncstatus: $syncstatus,
    lastsyncedat: $lastsyncedat,
    syncstate: $syncstate
  ) {
    id
    name
    stock
    price
    idbusiness
    idcategory
    createdat
    owner
    syncstatus
    syncstate
  }
}
'''),
        variables: product.toMap(),
      ),
    );

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    // result.data is a Map<String, dynamic>
    final data = result.data?['createProduct'];
    if (data == null) {
      throw Exception('No product returned from mutation');
    }
// imprime solo el objeto createProduct
    debugPrint("\n\n\n\n 📦 !!!!!!!!!!!!!!! Product response: $data \n\n\n\n");
    return Product.fromMap(data);
  }

  @override
  Future<void> delete(String id) async {
    await client.mutate(
      MutationOptions(
        document: gql(deleteProductMutation),
        variables: {'id': id},
      ),
    );
  }

  @override
  Stream<Product> subscribeToProductAdded() {
    return Amplify.API
        .subscribe(
          GraphQLRequest<String>(
            document: '''
          subscription OnCreateProduct {
            onCreateProduct {
              id
              idbusiness
              idcategory
              name
              image
              stock
              price
              created_at
            }
          }
        ''',
          ),
        )
        .map((event) {
          if (event.data == null) {
            throw Exception('Subscription event returned null');
          }

          debugPrint('GraphQL subscription event: ${event.data}');
          final decoded = jsonDecode(event.data!);

          final productJson = decoded['onCreateProduct'];
          if (productJson == null) {
            throw Exception('Subscription returned null product');
          }

          return Product.fromJson(productJson as Map<String, dynamic>);
        });
  }

  Future<Product> modifyProduct(Product product) async {
    final request = GraphQLRequest<String>(
      document: '''
    mutation UpdateProductAll(\$id: Int!, \$name: String!, \$stock: Int!, \$price: Float!) {
      updateProductAll(id: \$id, name: \$name, stock: \$stock, price: \$price) {
        id name stock price idbusiness idcategory image created_at
      }
    }
    ''',
      variables: {
        'id': product.id,
        'name': product.name,
        'stock': product.stock,
        'price': product.price,
      },
    );

    final response = await Amplify.API.mutate(request: request).response;

    print('Raw response.data: ${response.data}');
    final data = jsonDecode(response.data!);
    print('Decoded JSON: $data');
    print('Keys in JSON: ${data.keys}');

    // Aquí ajusta la clave al nombre correcto de la mutación
    final productJson = data['updateProductAll'];
    print('Product JSON: $productJson');

    return Product.fromJson(productJson);
  }

  Future<Product> updateProductStock(String id, int newStock) async {
    final request = GraphQLRequest<String>(
      document: '''
      mutation UpdateProduct(\$id: Int!, \$stock: Int!) {
        updateProduct(id: \$id, stock: \$stock) {
          id
          name
          stock
          price
          idbusiness
          idcategory
          image
          created_at
        }
      }
    ''',
      variables: {'id': id, 'stock': newStock},
    );

    final response = await Amplify.API.mutate(request: request).response;
    final data = jsonDecode(response.data!);
    return Product.fromJson(data['updateProduct']);
  }

  /// Nueva versión con paginación para lazy loading
  Future<List<Product>> fetchProductsByBusinessPaginated({
    required String idbusiness,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      await printAuthTokens();
      print(
        '>>> Ejecutando query con idbusiness=$idbusiness, limit=$limit, offset=$offset',
      );
      final response = await Amplify.API
          .query(
            request: GraphQLRequest<String>(
              document: '''
            query ListProductsByBusiness(\$idbusiness: Int!, \$limit: Int, \$offset: Int) {
              listProductsByBusiness(idbusiness: \$idbusiness, limit: \$limit, offset: \$offset) {
                id
                idbusiness
                idcategory
                name
                image
                stock
                price
                created_at
                owner
              }
            }
          ''',
              variables: {
                'idbusiness': idbusiness,
                'limit': limit,
                'offset': offset,
              },
            ),
          )
          .response;

      if (response.errors.isNotEmpty) {
        throw Exception('GraphQL errors: ${response.errors}');
      }

      final data = jsonDecode(response.data!);
      print('>>> Respuesta completa de AppSync: $data');

      final items = data['listProductsByBusiness'] as List<dynamic>? ?? [];
      final products = items.map((item) => Product.fromJson(item)).toList();

      return products;
    } catch (e) {
      safePrint('Error en fetchProductsByBusinessPaginated: $e');
      rethrow;
    }
  }

  Future<void> printAuthTokens() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      if (session is CognitoAuthSession) {
        //     print('>>> AccessToken: ${session.userPoolTokens?.accessToken}');
        //    print('>>> IdToken: ${session.userPoolTokens?.idToken}');
        //     print('>>> RefreshToken: ${session.userPoolTokens?.refreshToken}');
      } else {
        print(
          '>>> La sesión no es CognitoAuthSession, tipo: ${session.runtimeType}',
        );
      }
    } catch (e) {
      print('Error obteniendo tokens: $e');
    }
  }


  Future<int> deleteDemoProducts() async {
    return 0;  // metodo para borrar los registros de la tabla product marcados como demo = true  isdemo = true;
  }

  Future<void> deleteAllProducts() async {}
}
