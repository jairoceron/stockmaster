import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:uuid/uuid.dart'; // 👈 para generar UUID
import 'dart:async'; // <-- necesario para StreamSubscription

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:uuid/uuid.dart';

class SubscriptionDemo extends StatefulWidget {
  const SubscriptionDemo({Key? key}) : super(key: key);

  @override
  SubscriptionDemoState createState() => SubscriptionDemoState();
}

class SubscriptionDemoState extends State<SubscriptionDemo> {
  String log = "";
  StreamSubscription<GraphQLResponse<String>>? _subscription;

  void startSubscription() {
    final subscriptionRequest = GraphQLRequest<String>(
      document: '''
        subscription OnAddProduct(\$idbusiness: String!) {
          onAddProduct(idbusiness: \$idbusiness) {
            id
            name
            stock
            price
            idbusiness
            idcategory
            image
            createdat
            owner
            barcode
            stockminimumlevel
            deviceid
            platform
            ubicacion
            bodega
            syncstatus
            lastsyncedat
            syncstate
          }
        }
      ''',
      variables: {"idbusiness": "1"},
    );

    _subscription = Amplify.API.subscribe(
      subscriptionRequest,
      onEstablished: () {
        if (mounted) {
          setState(() {
            log += "✅ Suscripción establecida\n";
          });
        }
      },
    ).listen(
          (event) {
        if (mounted) {
          setState(() {
            log += "📦 Nuevo producto: ${event.data}\n";
          });
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() {
            log += "❌ Error en suscripción: $error\n";
          });
        }
      },
    );
  }

  Future<void> createProduct() async {
    final uuid = const Uuid().v4(); // 👈 genera un ID único

    final mutationRequest = GraphQLRequest<String>(
      document: '''
        mutation CreateProduct(
          \$id: ID!,
          \$name: String!,
          \$stock: Int!,
          \$price: Float!,
          \$idbusiness: String!,
          \$idcategory: String,
          \$image: String,
          \$createdat: AWSDateTime,
          \$owner: String,
          \$barcode: String,
          \$stockminimumlevel: Int,
          \$deviceid: String,
          \$platform: String,
          \$ubicacion: String,
          \$bodega: String,
          \$syncstatus: Boolean,
          \$lastsyncedat: AWSDateTime,
          \$syncstate: String
        ) {
          createProduct(
            id: \$id,
            name: \$name,
            stock: \$stock,
            price: \$price,
            idbusiness: \$idbusiness,
            idcategory: \$idcategory,
            image: \$image,
            createdat: \$createdat,
            owner: \$owner,
            barcode: \$barcode,
            stockminimumlevel: \$stockminimumlevel,
            deviceid: \$deviceid,
            platform: \$platform,
            ubicacion: \$ubicacion,
            bodega: \$bodega,
            syncstatus: \$syncstatus,
            lastsyncedat: \$lastsyncedat,
            syncstate: \$syncstate
          ) {
            id
            name
            stock
            price
            idbusiness
            idcategory
            image
            createdat
            owner
            barcode
            stockminimumlevel
            deviceid
            platform
            ubicacion
            bodega
            syncstatus
            lastsyncedat
            syncstate
          }
        }
      ''',
      variables: {
        "id": uuid,
        "name": "Producto de prueba",
        "stock": 10,
        "price": 9999.0,
        "idbusiness": "1",
        "idcategory": "CAT001",
        "image": "producto.png",
        "createdat": TemporalDateTime.now().format(),
        "owner": "tester",
        "barcode": "ABC123",
        "stockminimumlevel": 2,
        "deviceid": "dev01",
        "platform": "android",
        "ubicacion": "Bogotá",
        "bodega": "central",
        "syncstatus": true,
        "lastsyncedat": TemporalDateTime.now().format(),
        "syncstate": "pending",
      },
    );

    final response = await Amplify.API.mutate(request: mutationRequest).response;
    if (mounted) {
      setState(() {
        log += "🔨 Mutación ejecutada: ${response.data}\n";
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel(); // cancela la suscripción al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: startSubscription,
          child: const Text("Iniciar suscripción"),
        ),
        ElevatedButton(
          onPressed: createProduct,
          child: const Text("Crear producto de prueba"),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Text(log),
          ),
        ),
      ],
    );
  }
}
