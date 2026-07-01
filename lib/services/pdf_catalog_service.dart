// lib/services/pdf_catalog_service.dart
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:stockmaster/data/database/local/app_database.dart';

class PdfCatalogService {
  final AppDatabase db;

  PdfCatalogService(this.db);

  /// Helper para resolver cualquier tipo de imagen
  Future<pw.ImageProvider?> _resolveImage(String? path) async {
    if (path == null || path.isEmpty) return null;

    try {
      // Caso 1: Asset
      if (path.startsWith("assets/")) {
        final bytes = await rootBundle.load(path);
        return pw.MemoryImage(bytes.buffer.asUint8List());
      }

      // Caso 2: URL (nube)
      if (path.startsWith("http://") || path.startsWith("https://")) {
        final response = await http.get(Uri.parse(path));
        if (response.statusCode == 200) {
          return pw.MemoryImage(response.bodyBytes);
        }
      }

      // Caso 3: Ruta absoluta (sandbox / galería)
      final file = File(path);
      if (file.existsSync()) {
        return pw.MemoryImage(file.readAsBytesSync());
      }
    } catch (e) {
      print("Error cargando imagen: $e");
    }
    return null;
  }

  /// Catálogo estilo lista (uno debajo de otro)
  Future<File> generateListCatalog() async {
    final products = await db.productDao.getAllProducts();

    // Pre-cargar imágenes
    final productImages = <String, pw.ImageProvider?>{};
    for (final p in products) {
      productImages[p.id.toString()] = await _resolveImage(p.image);
    }

    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final fontBoldData = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    final poppins = pw.Font.ttf(fontData);
    final poppinsBold = pw.Font.ttf(fontBoldData);

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(base: poppins, bold: poppinsBold),
        build: (ctx) => products.map((p) {
          final productImage = productImages[p.id.toString()];

          return pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                if (productImage != null)
                  pw.Image(productImage, height: 150),
                pw.SizedBox(height: 8),
                pw.Text(p.name ?? "Producto",
                    style: pw.TextStyle(font: poppinsBold, fontSize: 16),
                    textAlign: pw.TextAlign.center),
                pw.Text(
                  "\$${p.price?.toStringAsFixed(2) ?? '0.00'}",
                  style: pw.TextStyle(
                      font: poppins, fontSize: 14, color: PdfColors.blueGrey800),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Divider(),
              ],
            ),
          );
        }).toList(),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/catalogo_list.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Catálogo estilo grilla (2 columnas × 4 filas por página)
  Future<File> generateGridCatalog() async {
    final products = await db.productDao.getAllProducts();

    // Pre-cargar imágenes
    final productImages = <String, pw.ImageProvider?>{};
    for (final p in products) {
      productImages[p.id.toString()] = await _resolveImage(p.image);
    }

    final pdf = pw.Document();

    final fontData = await rootBundle.load("assets/fonts/Poppins-Regular.ttf");
    final fontBoldData = await rootBundle.load("assets/fonts/Poppins-Bold.ttf");
    final poppins = pw.Font.ttf(fontData);
    final poppinsBold = pw.Font.ttf(fontBoldData);

    final logoData = await rootBundle.load("assets/icon/icon_00.png");
    final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(20),
          theme: pw.ThemeData.withFont(base: poppins, bold: poppinsBold),
          buildBackground: (ctx) => pw.Container(color: PdfColors.white),
        ),
        header: (ctx) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(logoImage, height: 40),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("Catálogo de productos",
                    style: pw.TextStyle(font: poppinsBold, fontSize: 16)),
                pw.UrlLink(
                  destination:
                  "https://play.google.com/store/apps/details?id=com.datatoool.stockmaster",
                  child: pw.Text("Descarga Stockmaster en Google Play",
                      style: pw.TextStyle(
                          font: poppins,
                          fontSize: 10,
                          color: PdfColors.blue)),
                ),
              ],
            ),
          ],
        ),
        build: (ctx) {
          final availableWidth = PdfPageFormat.a4.availableWidth;
          final itemWidth = (availableWidth - 60) / 2;

          return [
            pw.Center(
              child: pw.Wrap(
                spacing: 20,
                runSpacing: 20,
                children: products.map((p) {
                  final productImage = productImages[p.id.toString()];

                  return pw.Container(
                    width: itemWidth,
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        if (productImage != null)
                          pw.Image(productImage, height: 100),
                        pw.SizedBox(height: 8),
                        pw.Text(p.name ?? "Producto",
                            style: pw.TextStyle(
                                font: poppinsBold,
                                fontSize: 14,
                                color: PdfColors.black),
                            textAlign: pw.TextAlign.center),
                        pw.Text(
                          "\$${p.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: pw.TextStyle(
                            font: poppins,
                            fontSize: 12,
                            color: PdfColors.blueGrey800,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ];
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/catalogo_grid.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  /// Generar y abrir catálogo (lista o grilla) para compartir
  Future<void> generateAndSendCatalog({bool grid = true}) async {
    final file = grid ? await generateGridCatalog() : await generateListCatalog();
    await OpenFile.open(file.path);
  }
}
