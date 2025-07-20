import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate({
    required String text,
    required String fromLanguage,
    required String toLanguage,
  }) async {
    final translation = await _translator.translate(
      text,
      from: fromLanguage,
      to: toLanguage,
    );

    return translation.text;
  }

  Future<String> translateText({
    required String text,
    required String toLanguageCode,
  }) async {
    final translation = await _translator.translate(
      text,
      from: 'auto',
      to: toLanguageCode,
    );
    return translation.text;
  }
}
