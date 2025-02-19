import 'package:designhub/theme/designhub_colors.dart';
import 'package:flutter/material.dart';

ThemeData getCustomTheme() => ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: DesignhubColors.primary, // Or your DesignhubColors.primary
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color.fromRGBO(0, 0, 0, .06),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          gapPadding: 16,
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: DesignhubColors.grey),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(DesignhubColors.white),
          shape: WidgetStateProperty.all(
            CircleBorder(),
          ),
          overlayColor: WidgetStateProperty.all(DesignhubColors.black12),
          shadowColor: WidgetStateProperty.all(DesignhubColors.black26),
          elevation: WidgetStateProperty.all(4),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          side: WidgetStateProperty.all(
            BorderSide(
              width: 2,
              color: DesignhubColors.primary,
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: DesignhubColors.primary,
          foregroundColor: DesignhubColors.white,
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return DesignhubColors.white;
              }
              return DesignhubColors.grey300;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return DesignhubColors.black;
              }
              return DesignhubColors.grey700;
            },
          ),
          shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              );
            },
          ),
          side: WidgetStateProperty.all(BorderSide(
            color: DesignhubColors.grey300,
            width: 4,
          )),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 10, horizontal: 16)),
          animationDuration: Duration(milliseconds: 1),
        ),
      ),
    );
