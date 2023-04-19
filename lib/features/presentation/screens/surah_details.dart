import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_reader/core/utils/colors_manager.dart';
import 'package:quran_reader/features/data/models/surah_model.dart';
import 'package:quran_reader/features/presentation/controller/cubit/quran_cubit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../core/utils/assets_manager.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({
    super.key,
    required this.surah,
    this.startingVerseNumber,
  });

  final SurahModel surah;
  final int? startingVerseNumber;

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  // var isLoaded = false;
  // int? startingIndex;

  // @override
  // void initState() {
  //   if (widget.startingVerseNumber != null) {
  //     startingIndex = widget.startingVerseNumber! - 1;
  //   }
  //   void onListLoad() {
  //     if (!isLoaded) {
  //       isLoaded = true;
  //       return;
  //     }
  //     setState(() {
  //       startingIndex = null;
  //     });
  //     itemPositionsListener.itemPositions.removeListener(onListLoad);
  //     // log(itemPositionsListener.itemPositions.value.toString());
  //   }

  //   itemPositionsListener.itemPositions.addListener(onListLoad);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AssetsManager.appBarBg,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          widget.surah.surahName,
        ),
      ),
      body: BlocProvider(
        create: (context) => QuranCubit(),
        child: BlocBuilder<QuranCubit, QuranState>(
          builder: (context, state) {
            final cubit = QuranCubit.get(context);
            return Column(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Slider(
                    activeColor: ColorsManager.primary,
                    inactiveColor: Colors.white,
                    value: cubit.fontSize,
                    min: cubit.minFontSize,
                    max: cubit.maxFontSize,
                    onChanged: (value) {
                      cubit.onSliderChanged(value);
                    },
                  ),
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    initialScrollIndex: (widget.startingVerseNumber ?? 1) - 1,
                    itemPositionsListener: itemPositionsListener,
                    itemScrollController: itemScrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.surah.versesCount,
                    itemBuilder: (BuildContext context, int index) {
                      final verse = widget.surah.getVerseByNumber(index + 1);
                      return Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 10 : 0,
                          right: 10,
                          left: 10,
                          bottom: 10,
                        ),
                        child: Material(
                          color:
                              index == ((widget.startingVerseNumber ?? 0) - 1)
                                  ? Colors.amber
                                  : ColorsManager.primary.withAlpha(30),
                          child: InkWell(
                            onLongPress: () {
                              cubit.insertToDatabase(verse: verse);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                verse.verseContent,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: cubit.fontSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
