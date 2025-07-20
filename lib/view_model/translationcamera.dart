import 'package:flutter/material.dart';
import 'package:camera_ocr_scanner/services/TranslationServices.dart';

class TranslationcameraProvider extends ChangeNotifier {
  final TranslationService _translationService = TranslationService();

  String? translatedText;
  String? errorText;
  bool isLoading = false;


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
