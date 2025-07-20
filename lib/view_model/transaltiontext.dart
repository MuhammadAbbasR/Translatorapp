import 'package:camera_ocr_scanner/services/TranslationServices.dart';
import 'package:flutter/material.dart';


class TranslationProvider extends ChangeNotifier {
  final TranslationService _translationService = TranslationService();

  String? translatedText;
  String? errorText;
  bool isLoading = false;

  String fromLanguage = 'en';
  String toLanguage = 'es';

  Future<void> translateText(String inputText) async {
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
      final result = await _translationService.translate(
        text: inputText.trim(),
        fromLanguage: fromLanguage,
        toLanguage: toLanguage,
      );

      translatedText = 'Translated: $result';
    } catch (e) {
      errorText = 'Translation failed. Please check your internet connection.';
      translatedText = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void changeLanguages(String from, String to) {
    fromLanguage = from;
    toLanguage = to;
    notifyListeners();
  }



}
