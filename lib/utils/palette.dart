import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF3B6BDD);
const Color lightBlue = Color(0xFFF0F6FE);
const Color fillGrey = Color(0xFFF7F7F7);
const Color strokeGrey = Color(0xFFE7E7E7);

class Palette {
  static ThemeData getTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      primaryColor: primaryColor,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    );
  }
}
