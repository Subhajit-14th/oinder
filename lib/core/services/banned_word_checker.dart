import 'dart:convert';
import 'package:flutter/services.dart';

class BannedWordChecker {
  static List<String> _bannedWords = [];

  static Future<void> loadWords() async {
    final data = await rootBundle.loadString('assets/json/banned_words.json');
    final jsonData = json.decode(data);

    _bannedWords = List<String>.from(jsonData['banned_words']);
  }

  static bool containsBannedWord(String text) {
    final lowerText = text.toLowerCase();

    for (final word in _bannedWords) {
      if (lowerText.contains(word)) {
        return true;
      }
    }

    return false;
  }
}
