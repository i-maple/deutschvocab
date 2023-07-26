import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> speak(String text, String languageCode) async {
    await _flutterTts.setLanguage(
        'de'); // Set the language of the text (you can change this to your desired language code)
    await _flutterTts.setVolume(1.0);
    // await _flutterTts.setEngine(engine)
    await _flutterTts.speak(text);

  }

  static Map languages = {
    'english': 'en-us',
    'german': 'de',
  };
}
