import 'package:flutter/material.dart';

class ExcepcionPersonalizada {
  final String mensaje;
  final VoidCallback? accion;

  ExcepcionPersonalizada({required this.mensaje, this.accion});

  void mostrar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        mensaje,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      action: accion != null
          ? SnackBarAction(
        label: 'Ir',
        textColor: Colors.yellowAccent,
        onPressed: accion!,
      )
          : null,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}