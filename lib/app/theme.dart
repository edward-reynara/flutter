

import 'package:flutter/material.dart';

import 'Pallete.dart';

final ThemeData basicTheme = _buildBasicTheme();

ThemeData _buildBasicTheme() {
  Color primaryColor = Color.fromRGBO(2, 79, 137, 1);
  Color secondaryColor = Colors.deepPurpleAccent;
  final ColorScheme colorScheme = const ColorScheme.light()
      .copyWith(primary: primaryColor, secondary: secondaryColor);
  final ThemeData base = ThemeData(
    fontFamily: "Poppins",
    backgroundColor: Colors.white,
    primaryColor: primaryColor,
    primaryColorLight: secondaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: primaryColor,
    accentColor: secondaryColor,
    errorColor: Colors.red,
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    )
  );
  return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme));
}

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
      headline6: base.headline6.copyWith(fontFamily: 'Poppins'),
  );
}
