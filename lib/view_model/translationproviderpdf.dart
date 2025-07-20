import 'package:flutter/material.dart';

import '../services/TranslationServices.dart';


class TranslationPdfProvider extends ChangeNotifier {
  final TranslationService _translationService = TranslationService();

  String? extractedText;
  String? translatedText;
  String? errorText;
  bool isLoading = false;

  Future<void> translatePdfText({
    required String pdfText,
    required String toLanguageCode,
  }) async {
    isLoading = true;
    notifyListeners();

    extractedText = pdfText;

    translatedText = await _translationService.translateText(
      text: pdfText,
      toLanguageCode: toLanguageCode,
    );

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    extractedText = null;
    translatedText = null;
    notifyListeners();
  }


  String _selectedLanguage = 'en';

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String newLanguage) {
    _selectedLanguage = newLanguage;
    notifyListeners();
  }
  Future<void> translateText({
    required String inputText,
    required String toLanguage,
  }) async {
    if (inputText.trim().isEmpty) {
      errorText = 'Please enter text to translate.';
      translatedText = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorText = null;
    notifyListeners();

    try {
      final translation = await _translationService.translate(
        text: inputText,
        fromLanguage: 'auto',
        toLanguage: toLanguage,
      );

      translatedText = translation;
    } catch (e) {
      print('Translation Error: $e');
      errorText = 'Translation failed. Please check your internet connection.';
      translatedText = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}
