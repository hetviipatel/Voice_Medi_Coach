import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      primary: Colors.blue.shade700,
      onPrimary: Colors.white,
      secondary: Colors.blueAccent.shade100,
      onSecondary: Colors.black,
      tertiary: Colors.purple.shade400,
      onTertiary: Colors.white,
      error: Colors.red.shade400,
      onError: Colors.white,
      background: Colors.grey.shade50,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      iconTheme: const IconThemeData(color: Colors.blueAccent),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        foregroundColor: Colors.white, // Default text color for ElevatedButton
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueAccent,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blueAccent.shade400;
        }
        return Colors.grey.shade300;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.blueAccent,
      inactiveTrackColor: Colors.blue.shade100,
      thumbColor: Colors.blueAccent,
      overlayColor: Colors.blueAccent.withOpacity(0.2),
      valueIndicatorColor: Colors.blueAccent,
      valueIndicatorTextStyle: GoogleFonts.poppins(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blueAccent, width: 2),
      ),
      labelStyle: GoogleFonts.poppins(color: Colors.grey[600]),
      hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
      prefixIconColor: Colors.grey[600],
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
      primary: Colors.blue.shade400,
      onPrimary: Colors.black,
      secondary: Colors.blueAccent.shade400,
      onSecondary: Colors.white,
      tertiary: Colors.purple.shade200,
      onTertiary: Colors.black,
      error: Colors.red.shade200,
      onError: Colors.black,
      background: Colors.grey.shade900,
      onBackground: Colors.white,
      surface: Colors.grey.shade800,
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade800,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.blueAccent),
    ),
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade700),
      ),
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        foregroundColor: Colors.black, // Default text color for ElevatedButton
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blueAccent.shade100,
      ),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.blueAccent.shade100;
        }
        return Colors.grey.shade700;
      }),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.white;
      }),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: Colors.blueAccent.shade100,
      inactiveTrackColor: Colors.blue.shade900,
      thumbColor: Colors.blueAccent.shade100,
      overlayColor: Colors.blueAccent.shade100.withOpacity(0.2),
      valueIndicatorColor: Colors.blueAccent.shade100,
      valueIndicatorTextStyle: GoogleFonts.poppins(color: Colors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade700),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 2),
      ),
      labelStyle: GoogleFonts.poppins(color: Colors.grey[400]),
      hintStyle: GoogleFonts.poppins(color: Colors.grey[600]),
      prefixIconColor: Colors.grey[400],
    ),
  );
} 