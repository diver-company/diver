import 'package:diver/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData customThemeData(BuildContext context, {required bool isDark}) {
  final iconColor = isDark ? kContentColorDarkTheme : kContentColorLightTheme;
  final scaffoldColor = isDark ? kContentColorLightTheme : Colors.white;

  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: scaffoldColor,
    appBarTheme: AppBarTheme(elevation: 0, backgroundColor: scaffoldColor),
    iconTheme: IconThemeData(color: iconColor),
    textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme).copyWith(
      displayMedium: const TextStyle(fontSize: 64.0),
    ).apply(
      bodyColor: iconColor,
      displayColor: iconColor,
    ),
    colorScheme: isDark
        ? const ColorScheme.dark(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    )
        : const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
      error: kErrorColor,
    ),
  );
}