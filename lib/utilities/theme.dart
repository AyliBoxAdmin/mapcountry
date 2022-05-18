import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// THEME https://docs.flutter.dev/cookbook/design/themes

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFFFC107),
    onPrimary: Color(0xFA212121),
    secondary: Color(0xFFFFD740),
    tertiary: _lightFillColor,  // Text

    background: Colors.white,
    onBackground: Color(0xFF9E9E9E),

    surface: Color(0xFFFAFBFB),
    error: _lightFillColor,
    onError: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFFB3B3B0),
    brightness: Brightness.light,

  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFFC107),
    onPrimary: Color(0xFA212121),
    secondary: Color(0xFFFFD740),
    tertiary: _darkFillColor,  // Text

    background: Color(0xFF151515),
    onBackground: Color(0xFF2A2A2A),

    surface: Color(0xFF333331),
    error: _darkFillColor,
    onError: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface:  Color(0xFF737370),
    brightness: Brightness.dark,

  );

  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(

    bodyText1: GoogleFonts.montserrat(fontWeight: _semiBold,fontSize: 18),
    bodyText2: GoogleFonts.roboto(fontWeight: _regular),

/*
    headline1: GoogleFonts.anton(fontWeight: _medium),
    headline2: GoogleFonts.anton(fontWeight: _bold),
    headline3: GoogleFonts.dancingScript(fontWeight: _medium),
    headline4: GoogleFonts.libreBaskerville(fontWeight: _medium),
    headline5: GoogleFonts.libreBaskerville(fontWeight: _medium),
    headline6: GoogleFonts.oswald(fontWeight: _bold),

    subtitle1: GoogleFonts.raleway(fontWeight: _medium, fontSize: 18.0),
    subtitle2: GoogleFonts.roboto(fontWeight: _medium),

    caption: GoogleFonts.oswald(fontWeight: _medium),
    button: GoogleFonts.oswald(fontWeight: _semiBold),
    overline: GoogleFonts.oswald(fontWeight: _medium),
*/
  );


}


