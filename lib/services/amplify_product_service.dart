import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/product.dart';
import '../data/repositories/product_repository.dart';

import 'package:flutter/foundation.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/inventory_provider.dart';
import '../providers/user_provider.dart';

class AmplifyProductService implements ProductRepository {

  final GraphQLClient client;

  AmplifyProductService(this.client);

  @override
  Future<Product> add(Product product) async {

    print("XXX AmplifyProductService Esto es lo que tiene product... antes de guardar $product");

    try {
      final response = await Amplify.API
          .mutate(
        request: GraphQLRequest<String>(
          document: '''
      mutation CreateProduct(
        \$name: String!,
        \$stock: Int!,
        \$price: Float!,
        \$idbusiness: Int!,
        \$idcategory: Int!,
        \$owner: String!
      ) {
        createProduct(
          name: \$name,
          stock: \$stock,
          price: \$price,
          idbusiness: \$idbusiness,
          idcategory: \$idcategory,
          owner: \$owner
        ) {
          id
          name
          stock
          price
          idbusiness
          idcategory
          owner
        }
      }
    ''',
          variables: {

            'name': product.name,
            'stock': product.stock,
            'price': product.price,
            'idbusiness': product.idbusiness,
            'idcategory': product.idcategory,
            'owner': product.owner,
          },
        ),
      )
          .response;

      if (response.data == null) {
        throw Exception('Mutation failed: ${response.errors}');
      }

      debugPrint('GraphQL mutation response: ${response.data}');
      final decoded = jsonDecode(response.data!);

      final productJson = decoded['createProduct'];
      if (productJson == null) {
        throw Exception('Mutation returned null product');
      }

      return Product.fromJson(productJson as Map<String, dynamic>);
    } on AmplifyException catch (e) {
      debugPrint('Amplify error: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('Unexpected error: $e\n$stack');
      throw Exception('Failed to add product');
    }
  }




  Future<Product> addProduct(Product product) async {

    print("Esto es lo que tiene product... antes de guardar $product");

    try {
      final response = await Amplify.API
          .mutate(
            request: GraphQLRequest<String>(
              document: '''
      mutation CreateProduct(
        \$name: String!,
        \$stock: Int!,
        \$price: Float!,
        \$idbusiness: Int!,
        \$idcategory: Int!,
        \$owner: String!
      ) {
        createProduct(
          name: \$name,
          stock: \$stock,
          price: \$price,
          idbusiness: \$idbusiness,
          idcategory: \$idcategory,
          owner: \$owner
        ) {
          id
          name
          stock
          price
          idbusiness
          idcategory
          owner
        }
      }
    ''',
              variables: {

                'name': product.name,
                'stock': product.stock,
                'price': product.price,
                'idbusiness': product.idbusiness,
                'idcategory': product.idcategory,
                'owner': product.owner,
              },
            ),
          )
          .response;

      if (response.data == null) {
        throw Exception('Mutation failed: ${response.errors}');
      }

      debugPrint('GraphQL mutation response: ${response.data}');
      final decoded = jsonDecode(response.data!);

      final productJson = decoded['createProduct'];
      if (productJson == null) {
        throw Exception('Mutation returned null product');
      }

      return Product.fromJson(productJson as Map<String, dynamic>);
    } on AmplifyException catch (e) {
      debugPrint('Amplify error: ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('Unexpected error: $e\n$stack');
      throw Exception('Failed to add product');
    }
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
      variables: {
        'id': id,
        'stock': newStock,
      },
    );

    final response = await Amplify.API.mutate(request: request).response;
    final data = jsonDecode(response.data!);
    return Product.fromJson(data['updateProduct']);
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

  @override
  Future<void> saveProduct(Product product) async {
    await addProduct(product);
  }

  @override
  Future<List<Product>> fetchProducts() async {
    final response = await Amplify.API
        .query(
          request: GraphQLRequest<String>(
            document: '''
          query ListProducts {
            listProducts {
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
        .response;

    if (response.data == null) {
      throw Exception('Query failed: ${response.errors}');
    }

    debugPrint('GraphQL query response: ${response.data}');
    final decoded = jsonDecode(response.data!);

    final list = decoded['listProducts'];
    if (list == null) {
      debugPrint('Query returned null list');
      return [];
    }

    return (list as List<dynamic>)
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }


  @override
  Future<List<Product>> fetchProductsByBusiness(int idbusiness) async {
    final response = await Amplify.API
        .query(
          request: GraphQLRequest<String>(
            document: '''
          query ListProductsByBusiness(\$idbusiness: Int!) {
            listProductsByBusiness(idbusiness: \$idbusiness) {
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
            variables: {'idbusiness': idbusiness},
          ),
        )
        .response;

    if (response.data == null) {
      throw Exception('Query failed: ${response.errors}');
    }

    debugPrint('GraphQL query response: ${response.data}');
    final decoded = jsonDecode(response.data!);

    final list = decoded['listProductsByBusiness'];
    if (list == null) {
      debugPrint('No products returned for idbusiness: $idbusiness');
      return [];
    }

    return (list as List<dynamic>)
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override /// Nueva versión con paginación para lazy loading
  Future<List<Product>> fetchProductsByBusinessPaginated({
    required String idbusiness,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      await printAuthTokens();
      print(
          '>>> Ejecutando query con idbusiness=$idbusiness, limit=$limit, offset=$offset');
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


  @override
  Future<List<Product>> getAll(
    int idbusiness,
    int limit  ,
    int offset ,
  ) async {
    try {
      await printAuthTokens();
    //  print(
    //      '>>> Ejecutando query con idbusiness=$idbusiness, limit=$limit, offset=$offset');
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


  @override
  Future<List<Product>> getAllProducts() async {
      await printAuthTokens();
      //  print(
      //      '>>> Ejecutando query con idbusiness=$idbusiness, limit=$limit, offset=$offset');
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
            'idbusiness': 1,

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
  }

  @override
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

  @override
  Future<void> eliminateProduct(int id) async {
    final request = GraphQLRequest<String>(
      document: '''
      mutation DeleteProduct(\$id: Int!) {
        deleteProduct(id: \$id) { id }
      }
    ''',
      variables: {'id': id},
    );
    final response = await Amplify.API.mutate(request: request).response;
    if (response.data == null) throw Exception('Error al eliminar producto');
  }

  Future<void> delete(String id) async {
    final request = GraphQLRequest<String>(
      document: '''
      mutation DeleteProduct(\$id: Int!) {
        deleteProduct(id: \$id) { id }
      }
    ''',
      variables: {'id': id},
    );
    final response = await Amplify.API.mutate(request: request).response;
    if (response.data == null) throw Exception('Error al eliminar producto');
  }



  Future<void> printAuthTokens() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      if (session is CognitoAuthSession) {
       // print('>>> AccessToken: ${session.userPoolTokens?.accessToken}');
       // print('>>> IdToken: ${session.userPoolTokens?.idToken}');
       // print('>>> RefreshToken: ${session.userPoolTokens?.refreshToken}');
      } else {
        print(
            '>>> La sesión no es CognitoAuthSession, tipo: ${session.runtimeType}');
      }
    } catch (e) {
      print('Error obteniendo tokens: $e');
    }
  }


  Future<int> deleteDemoProducts() async {
    return 0;  // metodo para borrar los registros de la tabla product marcados como demo = true  isdemo = true;
  }


}
