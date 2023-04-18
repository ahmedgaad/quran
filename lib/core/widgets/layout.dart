import 'package:flutter/material.dart';
import 'package:quran_reader/core/utils/assets_manager.dart';

import '../../features/presentation/screens/archives.dart';
import '../../features/presentation/screens/surah.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AssetsManager.appBarBg,),fit: BoxFit.cover),
            ),
          ),
          title: const Text(
            'القرأن الكريم',
          ),
          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
            tabs: [
              Tab(
                child: Text('المحفوظات'),
              ),
              Tab(
                child: Text('السور'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const ArchivesTab(),
            SurahTab()
          ],
        ),
      ),
    );
  }
}
