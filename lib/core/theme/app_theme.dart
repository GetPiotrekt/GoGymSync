import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212), // główne tło (main background)
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFBB86FC), // akcent fioletowy (purple accent)
      secondary: Color(0xFF03DAC6), // akcent turkusowy (teal accent)
      surface: Color(0xFF121212),
      error: Colors.redAccent,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onSurfaceVariant: Colors.white,
      onError: Colors.black,
    ),

    // 🔹 Ustawienia dla ListTile / zaznaczenia elementów
    listTileTheme: const ListTileThemeData(
      selectedColor: Colors.white, // kolor tekstu, gdy zaznaczony (text color when selected)
      iconColor: Colors.white,
      selectedTileColor: Color(0x33BB86FC), // półprzezroczysty fiolet (semi-transparent purple)
      tileColor: Colors.transparent, // brak koloru tła dla niezaznaczonych (transparent background)
    ),

    // 🔹 Efekty kliknięcia i zaznaczenia
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFBB86FC),
        foregroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
  );
}