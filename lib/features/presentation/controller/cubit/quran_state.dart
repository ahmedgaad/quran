part of 'quran_cubit.dart';

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

class DatabaseCreatedSuccessfully extends QuranState {}

class DataRetrievedFromDBSuccessfully extends QuranState {}

class DataInsertedToDBSuccessfully extends QuranState {
  // List<VerseModel> verses;
}

class DataInsertedToDBFailed extends QuranState {}

class SliderChanged extends QuranState {}

class SurahList extends QuranState {}

class SearchResults extends QuranState {}
