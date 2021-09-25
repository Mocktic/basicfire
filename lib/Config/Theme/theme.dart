import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AppThemeData extends ChangeNotifier {
  //
  // Dark mode flag
  //
  bool darkMode = false;
  //
  // colors
  //
  Color colorGrey = Colors.grey[300];
  Color addedColor = HexColor("#43dfc1");
  Color addedMoreColor = HexColor("#00cca3");
  Color contrastColor = HexColor("#fc5203");
  Color buttonColor = HexColor('#050A30');

  Color colorPrimary = Color(0xff202f44);
  Color colorCompanion = Color(0xff00D9E2);
  Color colorCompanion2 = Color(0xff00D9E2);
  Color colorCompanion4 = Colors.green;
  Color colorCompanion5 = HexColor("#00b993");
  Color colorCompanion3 = HexColor("#62ebd0");

  Color colorBackground;
  Color navigationBarColor;
  Color colorBackgroundGray;
  Color colorDefaultText;
  Color colorBackgroundDialog;
  MaterialColor primarySwatch;
  List<Color> colorsGradient = [];
  Color colorDarkModeLight =
      Color.fromARGB(255, 40, 40, 40); // for dialog background in dark mode

  //
  TextStyle text10white;
  TextStyle text12Primary;
  TextStyle text12bold;
  TextStyle text12grey;
  TextStyle text14;
  TextStyle text14primary;
  TextStyle text14purple;
  TextStyle text14grey;
  TextStyle text14bold;
  TextStyle text14boldPimary;
  TextStyle text14boldWhite;
  TextStyle text14boldWhiteShadow;
  TextStyle text16;
  TextStyle text16bold;
  TextStyle text16boldWhite;
  TextStyle text16Primary;
  TextStyle text25boldPrimary;
  TextStyle text18boldPrimary;
  TextStyle text18boldPrimary2;
  TextStyle text18bold;
  TextStyle text20;
  TextStyle text20bold;
  TextStyle text20boldPrimary;
  TextStyle text20boldWhite;
  TextStyle text20negative;
  TextStyle text22primaryShadow;
  TextStyle text22boldPrimary;
  TextStyle robotoTextprimary;
  TextStyle robotoTextBold;

  changeDarkMode() {
    darkMode = !darkMode;
    init();
    notifyListeners();
  }

  init() {
    if (darkMode) {
      colorBackground = _backgroundDarkColor;
      colorDefaultText = _backgroundDarkColor;
      navigationBarColor = _backgroundDarkColor;
      colorBackgroundGray = Colors.white.withOpacity(0.1);
      primarySwatch = black;
      colorBackgroundDialog = colorDarkModeLight;
      Color _color2 = Color.fromARGB(80, 80, 80, 80);
      colorsGradient = [_color2, Colors.black];
      colorPrimary = Colors.white;
    } else {
      Color _color2 = Color.fromARGB(
          80, colorPrimary.red, colorPrimary.green, colorPrimary.blue);
      colorsGradient = [_color2, colorPrimary];
      colorBackgroundDialog = _backgroundColor;
      navigationBarColor = HexColor('#212f45').withOpacity(1);

      colorBackgroundGray = Colors.black.withOpacity(0.01);
      colorBackground = _backgroundColor;
      colorDefaultText = _backgroundColor;
      primarySwatch = white;
      colorPrimary = Color(0xff232323);
    }

    text10white = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );

    text12bold = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 12,
    );
    text12Primary = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    text12grey = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    text14 = TextStyle(
      color: colorDefaultText,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    text14primary = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    text14purple = GoogleFonts.merriweather(
      color: Colors.purple,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    text14bold = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );

    text14boldPimary = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );

    text14grey = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    text14boldWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 14,
    );

    text14boldWhiteShadow = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 14,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 1),
      ],
    );
    robotoTextprimary = GoogleFonts.robotoSlab(
      color: colorPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    robotoTextBold = GoogleFonts.robotoSlab(
      color: colorPrimary,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );

    text16bold = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 16,
    );

    text16boldWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 16,
    );

    text16 = TextStyle(
      color: colorDefaultText,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    text16Primary = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    );

    text25boldPrimary = TextStyle(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 25,
    );
    text22boldPrimary = TextStyle(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 22,
    );

    text18boldPrimary = GoogleFonts.poppins(
      color: colorPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );
    text18boldPrimary2 = GoogleFonts.merriweather(
      color: colorPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    );

    text18bold = TextStyle(
      color: colorDefaultText,
      fontWeight: FontWeight.w800,
      fontSize: 18,
    );

    text20bold = GoogleFonts.poppins(
      color: colorDefaultText,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    );

    text20boldPrimary = TextStyle(
      color: colorPrimary,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    );

    text20 = TextStyle(
      color: colorDefaultText,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );

    text20boldWhite = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w800,
      fontSize: 20,
    );

    text20negative = TextStyle(
      // text negative color
      color: colorBackground,
      fontWeight: FontWeight.w400,
      fontSize: 20,
    );

    text22primaryShadow = TextStyle(
        // text negative color
        color: colorPrimary,
        fontWeight: FontWeight.w800,
        fontSize: 22,
        shadows: [
          Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 1),
        ]);
  }
}

//
// Colors
//
var _backgroundColor = Colors.white;
var _backgroundDarkColor = Colors.grey[900];

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

const MaterialColor black = const MaterialColor(
  0xFF000000,
  const <int, Color>{
    50: const Color(0xFF000000),
    100: const Color(0xFF000000),
    200: const Color(0xFF000000),
    300: const Color(0xFF000000),
    400: const Color(0xFF000000),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  },
);
