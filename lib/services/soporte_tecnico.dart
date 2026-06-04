import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // para copiar al portapapeles

class SoporteTecnico {
  static Future<void> abrirWhatsApp(BuildContext context) async {
    const telefono = "573102952469"; // sin el "+"
    const mensaje =
        "Para cualquier duda que tengas en la utilización de esta app de inventario, "
        "por favor comunícate al WhatsApp $telefono. Con gusto atenderemos tus preguntas.";

    final url = Uri.parse("https://wa.me/$telefono?text=${Uri.encodeComponent(mensaje)}");

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _mostrarFallback(context, telefono, mensaje);
      }
    } catch (e) {
      _mostrarFallback(context, telefono, mensaje);
    }
  }

  static void _mostrarFallback(BuildContext context, String telefono, String mensaje) {
    final snackBar = SnackBar(
      content: Text(
        "No se pudo abrir WhatsApp.\n$mensaje",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Copiar número',
        textColor: Colors.yellowAccent,
        onPressed: () {
          Clipboard.setData(ClipboardData(text: telefono));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Número copiado al portapapeles")),
          );
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}