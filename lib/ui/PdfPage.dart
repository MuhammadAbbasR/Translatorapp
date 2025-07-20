import 'package:camera_ocr_scanner/constants/App_Colors.dart';
import 'package:camera_ocr_scanner/data/Languagedata.dart';
import 'package:camera_ocr_scanner/services/PDFservices.dart';
import 'package:camera_ocr_scanner/view_model/translationproviderpdf.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../widgets/TextContainer.dart';

class PdfTranslationPage extends StatelessWidget {
  PdfTranslationPage({super.key});



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: AppColors.Darkcolor,
        title:
        const Text('PDF Translator', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Consumer<TranslationPdfProvider>(
        builder: (context, provider, _) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Select Target Language:'),
                  DropdownButton<String>(
                    value: provider.selectedLanguage,
                    isExpanded: true,
                    items: languageMap.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.value,
                        child: Text(entry.key),
                      );
                    }).toList(),
                    onChanged: (value) {
                      provider.setLanguage(value!);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Upload a PDF to extract and translate text.'),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed:() async {
                      provider.reset();
                      final pdfPath = await PdfServices.pickPdfFile();
                      if (pdfPath != null) {
                        final text =
                        await PdfServices.extractTextFromPdf(pdfPath);
                        await provider.translatePdfText(
                          pdfText: text,
                          toLanguageCode: provider.selectedLanguage,
                        );
                      }
                    }
                    ,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Upload PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.Darkcolor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (provider.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else ...[
                    TextContainer(
                        'Extracted Text:', provider.extractedText, context),
                    TextContainer(
                        'Translated Text:', provider.translatedText, context),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: provider.translatedText != null
          ? () {
          PdfServices.generatePdf(provider.translatedText!);
          }
              : null,
                      child: const Text('Download Translated PDF'),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
