import 'package:flutter/material.dart';

const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
const defaultBackgroundColor = Colors.white;
const Color greyBackgroundCOlor = Color(0xffebecee);
Color selectedNavBarColor = Colors.cyan[800]!;
const unselectedNavBarColor = Colors.black87;
const appBarGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 101, 223, 217),
    Color.fromARGB(255, 101, 223, 217),
  ],
  stops: [0.5, 1.0],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);
const userDetailsGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 101, 223, 217),
    Color.fromARGB(255, 214, 249, 249),
  ],
  stops: [
    0.0,
    1.0,
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const dileverToGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 175, 239, 239),
    Color.fromARGB(255, 186, 250, 250),
  ],
  stops: [
    0.5,
    1.0,
  ],
);
final ThemeData lightTheme = ThemeData().copyWith(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  // primaryColor: Color.fromRGBO(254, 216, 19, 1),
  colorScheme: ColorScheme.light(primary: Colors.grey.shade200),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),

    headline5: TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black,
      fontSize: 17,
    ),

    // home layoutscreen text styles  :
    headlineLarge: TextStyle(
      color: Colors.black,
      fontSize: 23,
    ),
  ),
);
