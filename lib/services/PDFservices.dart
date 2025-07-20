import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/services.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfServices {
  static Future<String?> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  static Future<String> extractTextFromPdf(String filePath) async {
    final File file = File(filePath);

    // Load the PDF document
    final PdfDocument document =
    PdfDocument(inputBytes: file.readAsBytesSync());

    // Extract all the text from PDF
    String text = PdfTextExtractor(document).extractText();

    // Dispose document after use
    document.dispose();

    return text;
  }

  static Future<void> generatePdf(String translatedText) async {
    final pdf = pw.Document();

    // Load custom font with Unicode support
    final font = pw.Font.ttf(
      await rootBundle.load('assest/Roboto-Regular.ttf'),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Text(
            translatedText,
            style: pw.TextStyle(font: font, fontSize: 14),
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'translated.pdf',
    );



  }
}
