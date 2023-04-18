import 'package:quran/quran.dart';

class VerseModel {
  final int verseNumber;
  final String verseContent;
  final int surahNumber;

  VerseModel({
    required this.verseNumber,
    required this.surahNumber,
    required this.verseContent,
  });

  factory VerseModel.fromVerseAndSurahNumber({
    required int verseNumber,
    required int surahNumber,
  }) {
    return VerseModel(
      verseNumber: verseNumber,
      surahNumber: surahNumber,
      verseContent: getVerse(surahNumber, verseNumber, verseEndSymbol: true),
    );
  }
}
