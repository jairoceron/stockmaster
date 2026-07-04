import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class PdfSaleHelper {
  /// Genera un PDF elegante con la información de la venta
  static Future<Uint8List> generateSalePdf({
    required double total,
    required String paymentMethod,
    required DateTime date,
  }) async {
    final pdf = pw.Document();

    // Cargar imagen desde assets
    final imageBytes = await rootBundle.load('assets/icon/icon_00.png');
    final image = pw.MemoryImage(imageBytes.buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Venta Registrada",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text("Total: \$${total.toStringAsFixed(2)}",
                  style: pw.TextStyle(fontSize: 18)),
              pw.Text("Pago: $paymentMethod", style: pw.TextStyle(fontSize: 18)),
              pw.Text("Fecha: ${date.toLocal()}",
                  style: pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 20),
              pw.UrlLink(
                destination:
                "https://play.google.com/store/apps/details?id=com.datatoool.stockmaster",
                child: pw.Text("Descarga Stockmaster para ver detalles",
                    style: pw.TextStyle(
                        fontSize: 16,
                        color: PdfColors.blue,
                        decoration: pw.TextDecoration.underline)),
              ),
              pw.SizedBox(height: 20),
              pw.UrlLink(
                destination:
                "https://play.google.com/store/apps/details?id=com.datatoool.stockmaster",
                child: pw.Column(
                  children: [
                    pw.Image(image, width: 80, height: 80),
                    pw.Text("Descarga Stockmaster para ver detalles",
                        style: pw.TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  /// Envía el PDF generado a WhatsApp con el número indicado
  static Future<void> sendPdfToWhatsApp({
    required String phoneNumber,
    required double total,
    required String paymentMethod,
    required DateTime date,
  }) async {
    final pdfBytes = await generateSalePdf(
      total: total,
      paymentMethod: paymentMethod,
      date: date,
    );

    // Guardar temporalmente el PDF en memoria o filesystem
    // Aquí simplificamos usando url_launcher para abrir WhatsApp con mensaje
    final message =
        "Venta registrada: Total \$${total.toStringAsFixed(2)}, Pago: $paymentMethod, Fecha: $date.\nDescarga Stockmaster aquí: https://play.google.com/store/apps/details?id=com.datatoool.stockmaster";

    final whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=$message");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      throw Exception("No se pudo abrir WhatsApp");
    }
  }
}
