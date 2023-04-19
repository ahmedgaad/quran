import 'dart:developer';

import 'package:quran_reader/core/helpers/cache_network.dart';
import 'package:sqflite/sqflite.dart';

import '../models/verse_model.dart';

class VersesRepo {
  static final instance = VersesRepo();

  late Database database;
  late List<String> versesOrder;

  Future<void> initializeDB() async {
    await CacheHelper.init();
    log('--- main: CacheHelper.init ---');
    final String? versesOrderString = CacheHelper.getData(key: 'versesOrder');
    if (versesOrderString == null) {
      await CacheHelper.saveData(key: 'versesOrder', value: '');
      versesOrder = [];
    } else {
      if (versesOrderString.isEmpty) {
        versesOrder = [];
      } else {
        versesOrder = versesOrderString.split(' ');
      }
    }
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
    database.transaction(
      (txn) async {
        final id = await txn.rawInsert(
          'INSERT INTO verses(verse, surah) VALUES("${verse.verseNumber}", "${verse.surahNumber}")',
        );
        log('---- Transaction Inserted: $id ----');
        versesOrder.add(id.toString());
        await CacheHelper.saveData(
            key: 'versesOrder', value: versesOrder.join(' '));
      },
    );
  }

  Future<List<VerseModel>> getVerses() async {
    final versesData =
        (await database.rawQuery('SELECT * FROM verses')).toList();
    versesData.sort((verse1, verse2) {
      final verse1Index = versesOrder.indexOf('${verse1['id']}');
      final verse2Index = versesOrder.indexOf('${verse2['id']}');
      return verse1Index.compareTo(verse2Index);
    });
    return versesData
        .map(
          (verse) => VerseModel.fromVerseAndSurahNumber(
            verseNumber: verse['verse'] as int,
            surahNumber: verse['surah'] as int,
          ),
        )
        .toList();
  }

  saveReorderItems(int oldIndex, int newIndex) async {
    final verseOrder = versesOrder.removeAt(oldIndex);
    if (oldIndex > newIndex) {
      versesOrder.insert(newIndex, verseOrder);
    } else {
      versesOrder.insert(newIndex - 1, verseOrder);
    }
    // try {
    //   versesOrder.insert(newIndex, verseOrder);
    // } catch (e) {
    //   versesOrder.add(verseOrder);
    // }
    await CacheHelper.saveData(key: 'verseOrder', value: versesOrder.join(' '));
  }
}
