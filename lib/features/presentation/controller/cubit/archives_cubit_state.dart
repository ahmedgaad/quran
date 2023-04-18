// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'archives_cubit.dart';

@immutable
abstract class ArchivesState {}

class ArchivesCubitInitial extends ArchivesState {}

class ArchivesCubitLoadSuccess extends ArchivesState {
  final List<VerseModel> verses;
  ArchivesCubitLoadSuccess({
    required this.verses,
  });
}

class ArchivesCubitLoadFailed extends ArchivesState {}
