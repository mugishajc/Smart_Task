import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_task/utils/screen_size.dart';

class InkomokoSmartTaskTextStyle {
  static TextStyle headLine2(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 144),
    fontWeight: FontWeight.bold,
  );

  static TextStyle headLine3(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 42),
    fontWeight: FontWeight.w500,
  );

  static TextStyle headLine4(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 32),
    fontWeight: FontWeight.w500,
  );

  static TextStyle buttonText(BuildContext context, {fontWeight = FontWeight.normal}) =>
      GoogleFonts.quicksand(
        fontSize: InkomokoSmartTaskSize.width(context, 27),
        fontWeight: fontWeight,
      );

  /// Normal Texts
  static TextStyle bodyText1(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 27),
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyText2(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 24),
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyText3(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 22),
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyText4(BuildContext context) => GoogleFonts.quicksand(
    fontSize: InkomokoSmartTaskSize.width(context, 18),
    fontWeight: FontWeight.normal,
  );

  /// Subtitles
  static TextStyle subtitle1 = const TextStyle( // Made const
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  static TextStyle subtitle2 = const TextStyle( // Made const
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );
}