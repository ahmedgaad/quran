import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quran_reader/features/data/models/surah_model.dart';
import 'package:quran_reader/features/data/models/verse_model.dart';
import 'package:quran_reader/features/presentation/screens/surah_details.dart';

class VerseCard extends StatelessWidget {
  VerseCard({
    super.key,
    required this.verse,
  });

  final VerseModel verse;
  final GlobalKey _textKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.hardEdge,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SurahScreen(
                surah: SurahModel.fromSurahNumber(verse.surahNumber),
                startingVerseNumber: verse.verseNumber,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Text(
            verse.verseContent,
            key: _textKey,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
