import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class TTextTheme {
  // Light theme
  static const Color _lightPrimaryColor = Colors.black;
  static const Color _lightSecondaryColor = Colors.deepPurple;
  static const Color _lightTextColor = Colors.black87;
  static const Color _lightSubTextColor = Colors.black54;

  static const TextStyle _lightDisplayMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: _lightTextColor,
    fontSize: 36.0,
  );
  
  static const TextStyle _lightTitleSmall = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: _lightSecondaryColor,
    fontSize: 24.0,
  );

  static const TextStyle _lightBodyText = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    color: _lightTextColor,
    fontSize: 16.0,
  );

  static const TextStyle _lightSubText = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    color: _lightSubTextColor,
    fontSize: 14.0,
  );

  // Dark theme
  static const Color _darkPrimaryColor = Colors.white;
  static const Color _darkSecondaryColor = Colors.deepPurple;
  static const Color _darkTextColor = Colors.white;
  static const Color _darkSubTextColor = Colors.white54;

  static const TextStyle _darkDisplayMedium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    color: _darkTextColor,
    fontSize: 36.0,
  );
  
  static const TextStyle _darkTitleSmall = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    color: _darkSecondaryColor,
    fontSize: 24.0,
  );

  static const TextStyle _darkBodyText = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    color: _darkTextColor,
    fontSize: 16.0,
  );

  static const TextStyle _darkSubText = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    color: _darkSubTextColor,
    fontSize: 14.0,
  );

  // Themes
  static final TextTheme lightTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(textStyle: _lightDisplayMedium),
    titleSmall: GoogleFonts.poppins(textStyle: _lightTitleSmall),
    bodyText1: _lightBodyText,
    bodyText2: _lightBodyText,
    subtitle1: _lightSubText,
    subtitle2: _lightSubText,
  );

  static final TextTheme darkTextTheme = TextTheme(
    displayMedium: GoogleFonts.montserrat(textStyle: _darkDisplayMedium),
    titleSmall: GoogleFonts.poppins(textStyle: _darkTitleSmall),
    bodyText1: _darkBodyText,
    bodyText2: _darkBodyText,
    subtitle1: _darkSubText,
    subtitle2: _darkSubText,
  );
}
