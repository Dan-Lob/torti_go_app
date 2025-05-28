import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final _baseTextTheme = GoogleFonts.poppinsTextTheme();

  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: Colors.indigo,
    textTheme: _baseTextTheme,
  );

  static final dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.indigo,
    textTheme: _baseTextTheme,
  );
}
