import 'package:flutter/material.dart';
import 'package:quran_reader/features/data/models/surah_model.dart';

import '../widgets/surah_card.dart';

class SurahTab extends StatelessWidget {
  SurahTab({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _searchController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    hintText: '... ابحث عما تريد ',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final surah = SurahModel.fromSurahNumber(index + 1);
                    return SurahCard(
                      surah: surah,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                  itemCount: 114,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
