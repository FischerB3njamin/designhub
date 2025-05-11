import 'package:flutter/material.dart';

class CustomTextStyles {
  // === Body Large ===
  static TextStyle bodyLarge(BuildContext context) {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle bodyLargeBold(BuildContext context, FontWeight fontWeight) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: fontWeight,
        );
  }

  static TextStyle bodyLargeColorBold(
      BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
  }

  // === Body Medium ===
  static TextStyle bodyMedium(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle bodyMediumBold(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle bodyMediumColor(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
        );
  }

  // === Body Small ===
  static TextStyle bodySmall(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!;
  }

  static TextStyle bodySmallColor(BuildContext context, Color color) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
          color: color,
        );
  }

  // === Headline ===
  static TextStyle headlineLarge(BuildContext context) {
    return Theme.of(context).textTheme.headlineLarge!;
  }

  static TextStyle headlineMedium(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  static TextStyle headlineSmallBold(
      BuildContext context, FontWeight fontWeight) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: fontWeight,
        );
  }

  // === Label ===
  static TextStyle labelSmallColor(BuildContext context, Color color) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(
          color: color,
        );
  }

  static TextStyle labelLargeColorBold(
      BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
  }

  // === Title ===
  static TextStyle titleLarge(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle titleLargeBold(BuildContext context, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: fontWeight,
        );
  }

  static TextStyle titleMediumBold(
      BuildContext context, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: fontWeight,
        );
  }

  static TextStyle titleMediumColorBold(
      BuildContext context, Color color, FontWeight fontWeight) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
        );
  }
}
