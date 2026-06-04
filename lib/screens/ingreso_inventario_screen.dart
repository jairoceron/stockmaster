import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:async';
import '../models/transaction.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/user.dart'; // your AppUser model
import '../providers/user_provider.dart';
import '/helpers/transaction_utils.dart';
import '/helpers/barConfig.dart';
import 'package:provider/provider.dart';

class IngresoInventarioScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Transaction transaction;

  const IngresoInventarioScreen({
    super.key,
    required this.product,
    required this.transaction,
  });

  @override
  _IngresoInventarioScreenState createState() =>
      _IngresoInventarioScreenState();
}

class _IngresoInventarioScreenState extends State<IngresoInventarioScreen> {
  late TextEditingController quantityController;
  late TextEditingController addQuantController;
  late TextEditingController conceptController;
  late IOWebSocketChannel channel;
  late StreamSubscription subscription;
  String message = "";



  @override
  void initState() {
    super.initState();

    channel = IOWebSocketChannel.connect(
      "wss://2hhwqrov1k.execute-api.us-east-2.amazonaws.com/production/",
    );

    subscription = channel.stream.listen((data) {
      print("RAW WebSocket data: $data");

      try {
        final decoded = jsonDecode(data);
        print("DECODED JSON: $decoded");

        if (decoded is Map) {
          final status = decoded["status"];
          final qty = decoded["qty"];
          final errorMsg = decoded["message"];

          print("Status: $status");
          print("Qty: $qty");
          print("ErrorMsg: $errorMsg");

          if (status == "success") {
            print("New quantity received: $qty");
            if (mounted) {
              // SnackBar verde de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Stock actualizado: $qty unidades"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, qty); // ✅ devuelve cantidad real
            }
          } else if (status == "error") {
            print("Error recibido: $errorMsg");
            if (mounted) {
              // SnackBar rojo de error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error al actualizar: $errorMsg"),
                  backgroundColor: Colors.red,
                ),
              );
              // No cerramos la pantalla, el usuario puede intentar de nuevo
            }
          }
        }
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    });

    // ✅ Inicializar controladores
    quantityController = TextEditingController(
      text: widget.product["quantity"].toString(),
    );
    addQuantController = TextEditingController();
    conceptController = TextEditingController();
  }

  @override
  void dispose() {
    subscription.cancel();
    channel.sink.close(status.goingAway);
    quantityController.dispose();
    addQuantController.dispose();
    conceptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppBarConfigUtils.getConfig(widget.transaction.transactionType);


    return Scaffold(
      appBar: AppBar(
        title: Text(config.title),
        centerTitle: true,
        backgroundColor: config.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top tag : product name
            Text(
              widget.product["name"].toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Other widgets go here
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: "Current Quantity"),
              readOnly: true, // show existing quantity
            ),
            TextField(
              controller: addQuantController,
              decoration: InputDecoration(labelText: AppBarConfigUtils.getQuantityLabel(widget.transaction.transactionType)),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: conceptController,
              decoration: const InputDecoration(labelText: "Concept"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Recuperar valores de los TextFields
                final variable_quantity =
                    int.tryParse(addQuantController.text) ?? 0;
                final variable_concept = conceptController.text;

                // Recuperar usuario
                final appUser = Provider.of<UserProvider>(
                  context,
                  listen: false,
                ).user;

                // Ajustar cantidad según tipo de transacción
                // Usar el helper para ajustar la cantidad
                final adjustedQuantity = TransactionUtils.adjustQuantity(
                  widget.transaction.transactionType,
                  variable_quantity,
                );

                // Construir el payload

                final payload = {
                  "action": "stockMielChange",
                  "idProduct": widget.product["id"].toString(),
                  "qty": variable_quantity,
                  "concept": variable_concept,
                  "user": appUser?.username,
                  "tipoTransaccion": widget.transaction.transactionType,
                };

                print("XXXXXXXX este es el payload ::::: $appUser?.username");
                print("Payload: $payload");
                print("Username: ${appUser?.username}");
                print("*********** TIPO DE TRANSACCION: ${widget.transaction.transactionType}");

                // Enviar al WebSocket
                channel.sink.add(jsonEncode(payload));

                // Feedback en pantalla
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Update enviado al servidor, esperando confirmación...",
                    ),
                  ),
                );

                // ❌ REMOVE Navigator.pop(context, true);
                // We wait for the server response in the listener
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
