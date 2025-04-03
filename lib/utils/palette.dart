import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF3B6BDD);
const Color lightBlue = Color(0xFFF0F6FE);

class Palette {
  static ThemeData getTheme() {
    return ThemeData(
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }
}
