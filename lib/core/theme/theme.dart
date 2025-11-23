import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme() {
  const primaryColor = Color(0xFF3B5AFE);
  const secondaryColor = Color(0xFF7C82F4);
  const backgroundColor = Color(0xFFF5F7FA);

  final textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
    bodyLarge: GoogleFonts.openSans(
      fontSize: 16, color: Colors.black87),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 14, color: Colors.black54),
    labelLarge: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor),
  );

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      background: backgroundColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    ),
  );
}
