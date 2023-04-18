import 'package:quran/quran.dart';
import 'package:quran_reader/features/data/models/verse_model.dart';

class SurahModel {
  final String surahName;
  final int surahNumber;
  final String palceOfRevealation;
  final int versesCount;

  SurahModel({
    required this.surahName,
    required this.surahNumber,
    required this.palceOfRevealation,
    required this.versesCount,
  });

  factory SurahModel.fromSurahNumber(int surahNumber) {
    return SurahModel(
      surahName: getSurahNameArabic(surahNumber),
      surahNumber: surahNumber,
      palceOfRevealation:
          getPlaceOfRevelation(surahNumber) == 'Makkah' ? 'مكية' : 'مدنية',
      versesCount: getVerseCount(surahNumber),
    );
  }

  VerseModel getVerseByNumber(int verseNumber) {
    return VerseModel.fromVerseAndSurahNumber(
      verseNumber: verseNumber,
      surahNumber: surahNumber,
    );
  }
}
