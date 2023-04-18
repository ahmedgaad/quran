import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_reader/features/data/models/verse_model.dart';
import 'package:quran_reader/features/data/repo/verses_repo.dart';

part 'archives_cubit_state.dart';

class ArchivesCubit extends Cubit<ArchivesState> {
  ArchivesCubit() : super(ArchivesCubitInitial()) {
    _loadVerses();
  }
  final _verseRepo = VersesRepo.instance;
  

  _loadVerses() async {
    try {
      final verses = await _verseRepo.getVerses();
      emit(ArchivesCubitLoadSuccess(verses: verses));
    } catch (e) {
      emit(ArchivesCubitLoadFailed());
    }
  }

  reorderItems(int oldIndex, int newIndex) {
    final verses = (state as ArchivesCubitLoadSuccess).verses;
    final verse = verses.removeAt(oldIndex);
    verses.insert(newIndex, verse);
    emit(ArchivesCubitLoadSuccess(verses: verses));
  }
}
