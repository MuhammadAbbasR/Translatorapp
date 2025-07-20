// lib/ui/simple_translation_page.dart

import 'package:camera_ocr_scanner/data/Languagedata.dart';
import 'package:camera_ocr_scanner/view_model/transaltiontext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TranslationPage extends StatelessWidget {
  const TranslationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final translationProvider = Provider.of<TranslationProvider>(context);
    final TextEditingController inputController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      appBar: AppBar(
        title: const Text(
          'Text Translator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: translationProvider.fromLanguage,
                      isExpanded: true,
                      items: languageMap.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(entry.key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        translationProvider.changeLanguages(
                          value!,
                          translationProvider.toLanguage,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<String>(
                      value: translationProvider.toLanguage,
                      isExpanded: true,
                      items: languageMap.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.value,
                          child: Text(entry.key),
                        );
                      }).toList(),
                      onChanged: (value) {
                        translationProvider.changeLanguages(
                          translationProvider.fromLanguage,
                          value!,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: inputController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Type your text here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: translationProvider.isLoading
                    ? null
                    : () {
                  translationProvider.translateText(inputController.text);
                },
                icon: const Icon(Icons.translate),
                label: const Text('Translate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (translationProvider.isLoading) ...[
                const Center(child: CircularProgressIndicator()),
              ] else if (translationProvider.errorText != null) ...[
                Text(
                  translationProvider.errorText!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ] else if (translationProvider.translatedText != null) ...[
                const Text(
                  'Translated Text:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      translationProvider.translatedText!,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
