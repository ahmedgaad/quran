import 'package:flutter/material.dart';
import 'package:quran_reader/features/data/models/surah_model.dart';
import 'package:quran_reader/features/presentation/screens/surah_details.dart';

import '../../../core/utils/assets_manager.dart';
import '../../../core/utils/colors_manager.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({
    super.key,
    required this.surah,
  });

  final SurahModel surah;

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
              builder: (_) => SurahScreen(surah: surah),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Image.asset(
                AssetsManager.book,
                height: 61,
                width: 61,
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(surah.surahName),
                  Text(
                    'رقم السورة: ${surah.surahNumber}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.palceOfRevealation,
                    style: const TextStyle(
                      color: ColorsManager.primary,
                    ),
                  ),
                  Text(
                    'عدد أياتها: ${surah.versesCount}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
