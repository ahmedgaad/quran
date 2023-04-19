import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_reader/features/presentation/controller/cubit/archives_cubit.dart';

import '../widgets/verse_card.dart';

class ArchivesTab extends StatefulWidget {
  const ArchivesTab({super.key});

  @override
  State<ArchivesTab> createState() => _ArchivesTabState();
}

class _ArchivesTabState extends State<ArchivesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivesCubit(),
      child: BlocBuilder<ArchivesCubit, ArchivesState>(
        builder: (context, state) {
          if (state is ArchivesCubitLoadSuccess) {
            if (state.verses.isEmpty) {
              return const Center(
                child: Text(
                  'لايوجد محفوظات بعد',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 30,
                  ),
                ),
              );
            }
            return ReorderableListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  key: Key(index.toString()),
                  padding: EdgeInsets.only(
                    bottom: 10,
                    right: 10,
                    left: 10,
                    top: index == 0 ? 10 : 0,
                  ),
                  child: VerseCard(
                    verse: state.verses[index],
                  ),
                );
              },
              itemCount: state.verses.length,
              onReorder: (int oldIndex, int newIndex) {
                BlocProvider.of<ArchivesCubit>(context).reorderItems(
                  oldIndex,
                  newIndex,
                );
              },
            );
          } else if (state is ArchivesCubitInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text(
                'لقد حدث خطأ ما',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
