import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../models/verse_model.dart';

class VersesRepo {
  static final instance = VersesRepo();

  late Database database;
  Future<void> initializeDB() async {
    database = await openDatabase(
      'quran.db',
      version: 1,
      onCreate: (db, version) async {
        await db
            .execute(
          'CREATE TABLE verses (id INTEGER PRIMARY KEY, verse INTEGER, surah INTEGER)',
        )
            .then(
          (value) {
            log('---- Table Created ----');
          },
        ).catchError(
          (e) {
            log('---- Error through create database: ${e.toString()} ----');
          },
        );
      },
    );
  }

  void insertToDatabase({
    required VerseModel verse,
  }) {
    database.transaction((txn) async {
      final id = await txn.rawInsert(
        'INSERT INTO verses(verse, surah) VALUES("${verse.verseNumber}", "${verse.surahNumber}")',
      );
      log('---- Transaction Inserted: $id ----');
    });
  }

  Future<List<VerseModel>> getVerses() async {
    final versesData =
        await database.rawQuery('SELECT * FROM verses');

    return versesData
        .map(
          (verse) => VerseModel.fromVerseAndSurahNumber(
            verseNumber: verse['verse'] as int,
            surahNumber: verse['surah'] as int,
          ),
        )
        .toList();
  }
}
