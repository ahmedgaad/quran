import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_reader/features/data/models/verse_model.dart';
import 'package:quran_reader/features/data/repo/verses_repo.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/surah_model.dart';

part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());

  static QuranCubit get(context) => BlocProvider.of(context);

  double fontSize = 16.0;
  final minFontSize = 12.0;
  final maxFontSize = 48.0;
  onSliderChanged(double value) {
    fontSize = value;
    emit(SliderChanged());
  }

  final _verseRepo = VersesRepo.instance;

  Future<void> insertToDatabase({
    required VerseModel verse,
  }) async {
    try {
      _verseRepo.insertToDatabase(verse: verse);
      emit(DataInsertedToDBSuccessfully());

    } catch (error) {
      log('---- Transaction Failed: ${error.toString()} ----');
      emit(DataInsertedToDBFailed());
    }
  }
}
