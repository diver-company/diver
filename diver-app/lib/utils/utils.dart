import 'package:diver/constants.dart';
import 'package:flutter/material.dart';

Color themeBasedDimmedContentColor(context) {
  return Theme.of(context).brightness ==
      Brightness.light
      ? kDimmedContentColorDarkTheme
      : kDimmedContentColorLightTheme;
}

BorderSide themeBasedBorderSide(BuildContext context) {
  return BorderSide(
    color: Theme.of(context).brightness == Brightness.light ? kContentColorLightTheme : kContentColorDarkTheme,
  );
}