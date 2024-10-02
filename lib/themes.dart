import "package:flutter/material.dart";
import "package:json_kasten/colors.dart";

final darkTheme = ThemeData.dark().copyWith(
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: AppColors.white,
      fixedSize: const Size(200, 50),
      textStyle: const TextStyle(fontSize: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blueAccent,
    selectionHandleColor: Colors.blueAccent,
    selectionColor: Colors.blueAccent.withOpacity(0.2),
  ),
);

final lightTheme = ThemeData.light().copyWith(
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.blueAccent,
      foregroundColor: AppColors.white,
      fixedSize: const Size(200, 50),
      textStyle: const TextStyle(fontSize: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.blueAccent,
    selectionHandleColor: Colors.blueAccent,
    selectionColor: Colors.blueAccent.withOpacity(0.2),
  ),
);
