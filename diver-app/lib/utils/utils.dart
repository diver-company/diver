import 'package:diver/constants.dart';
import 'package:flutter/material.dart';

Color themeBasedContentColor(context) {
  return Theme.of(context).brightness ==
      Brightness.light
      ? kDimmedContentColorDarkTheme
      : kDimmedContentColorLightTheme;
}