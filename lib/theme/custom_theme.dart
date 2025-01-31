import 'package:flutter/material.dart';

ThemeData getCustomTheme() => ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, .06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          gapPadding: 16,
          borderSide: BorderSide.none,
        ),
        hintStyle:
            TextStyle(color: Colors.grey), // Optional: Stil für Hint-Text
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            CircleBorder(),
          ),
          overlayColor: WidgetStateProperty.all(Colors.black12),
          shadowColor: WidgetStateProperty.all(Colors.black26),
          elevation: WidgetStateProperty.all(4),
        ),
      ),
    );
