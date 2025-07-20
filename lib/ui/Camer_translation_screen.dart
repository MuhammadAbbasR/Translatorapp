import 'dart:ffi';

import 'package:camera_ocr_scanner/view_model/translationcamera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../constants/App_Colors.dart';

class CameraTranslationPage extends StatefulWidget {
  const CameraTranslationPage({super.key});

  @override
  State<CameraTranslationPage> createState() => _CameraTranslationPageState();
}

class _CameraTranslationPageState extends State<CameraTranslationPage> {
  String _scannedText = '';
  String _targetLanguage = 'es';  // Example: Spanish

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.Darkcolor,
        title: const Text('Camera Translator', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<TranslationcameraProvider>(
          builder: (context, translationProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Scan text using your camera and translate it.'),
                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await context.push<String>('/camera');
                    if (result != null && result is String) {
                      setState(() {
                        _scannedText = result;
                      });
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Open Camera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Darkcolor,
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Scanned Text:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: translationProvider.selectedLanguage,
                      items: <String, String>{
                        'English': 'en',
                        'Spanish': 'es',
                        'French': 'fr',
                        'German': 'de',
                        'Urdu': 'ur',
                        'Chinese': 'zh-cn',
                        'Arabic': 'ar',
                        'Hindi': 'hi',
                      }.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(entry.key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        translationProvider.setLanguage(value!);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        _scannedText.isNotEmpty
                            ? _scannedText
                            : 'No text scanned yet.',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: _scannedText.isNotEmpty
                      ? () {
                    translationProvider.translateText(
                      inputText: _scannedText,
                      toLanguage: translationProvider.selectedLanguage,
                    );
                  }
                      : null,
                  icon: const Icon(Icons.translate),
                  label: const Text('Translate'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.Darkcolor,
                    foregroundColor: Colors.white,
                  ),
                ),

                const SizedBox(height: 20),

                if (translationProvider.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      translationProvider.translatedText ?? 'Translation will appear here.',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
