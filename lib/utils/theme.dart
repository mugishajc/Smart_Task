import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

enum ThemeMode {
  LIGHT,
  DARK,
}

class SmartTaskTheme {
  static var kThemeMode = ThemeMode.LIGHT;

  static bool darkMode() => kThemeMode == ThemeMode.DARK;
}

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed( // Using fromSeed for better defaults
    seedColor: InkomokoSmartTaskColors.primary,
    brightness: SmartTaskTheme.darkMode() ? Brightness.dark : Brightness.light,
    background: SmartTaskTheme.darkMode() ? InkomokoSmartTaskColors.spaceCadet : InkomokoSmartTaskColors.white, // Setting background here
  ),
  scaffoldBackgroundColor:
  SmartTaskTheme.darkMode() ? InkomokoSmartTaskColors.spaceCadet : InkomokoSmartTaskColors.white,
  primaryColor: InkomokoSmartTaskColors.primary,
  primarySwatch: InkomokoSmartTaskColors.createMaterialColor(InkomokoSmartTaskColors.primary),
  appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(size: 16),
      actionsIconTheme: const IconThemeData(size: 16),
      surfaceTintColor: InkomokoSmartTaskColors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: InkomokoSmartTaskColors.charcoal,
        fontWeight: FontWeight.w500,
      )),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);