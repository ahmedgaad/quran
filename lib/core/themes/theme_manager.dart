import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors_manager.dart';

class ThemeManager {
  static  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorsManager.scaffoldBg,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.primary,

    ),
    fontFamily: GoogleFonts.amiri().fontFamily,
  );
}
