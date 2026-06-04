
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:async';
import '../models/transaction.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/user.dart'; // your AppUser model
import '/helpers/transaction_utils.dart';
import '/screens/ingreso_inventario_screen.dart';
import 'package:provider/provider.dart';

class LookLikeScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Transaction transaction;

  const LookLikeScreen({
    super.key,
    required this.product,
    required this.transaction,
  });

  @override
  State<LookLikeScreen> createState() =>
      _LookLikeScreenState();
}



class _LookLikeScreenState extends State<LookLikeScreen> {
  // Helper para obtener configuración de AppBar
  Map<String, dynamic> _getAppBarConfig() {
    if (widget.transaction.transactionType == "input") {
      return {
        "title": "Units Added",
        "color": Colors.green,
      };
    } else if (widget.transaction.transactionType == "output") {
      return {
        "title": "Units Removed",
        "color": Colors.red, // aquí puedes diferenciar el color si quieres
      };
    }
    return {
      "title": "Inventory",
      "color": Colors.blueGrey,
    };
  }

  @override
  Widget build(BuildContext context) {
    final config = _getAppBarConfig();

    return Scaffold(
      appBar: AppBar(
        title: Text(config["title"]),
        centerTitle: true,
        backgroundColor: config["color"],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Contenido…"),
      ),
    );
  }

  String _getQuantityLabel() {
    if (widget.transaction.transactionType == "input") {
      return "Add Quantity";
    } else if (widget.transaction.transactionType == "output") {
      return "Remove Quantity";
    }
    return "Quantity";
  }



}

