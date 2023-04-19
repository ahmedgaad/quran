import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_reader/core/helpers/cache_network.dart';
import 'package:quran_reader/core/themes/theme_manager.dart';
import 'package:quran_reader/features/data/repo/verses_repo.dart';
import 'package:quran_reader/features/presentation/controller/cubit/quran_cubit.dart';

import 'core/helpers/observer.dart';
import 'core/widgets/layout.dart';

void main() async {
  log('--- main ---');
  WidgetsFlutterBinding.ensureInitialized();
  log('--- main: WidgetsFlutterBinding.ensureInitialized ---');

  Bloc.observer = MyBlocObserver();
  log('--- main: MyBlocObserver ---');

  await VersesRepo.instance.initializeDB();
  log('--- main: VersesRepo.instance.initializeDB ---');

  runApp(const QuranReader());
}

class QuranReader extends StatelessWidget {
  const QuranReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'القرأن الكريم',
        theme: ThemeManager.lightTheme,
        home: const LayoutScreen(),
      ),
    );
  }
}
