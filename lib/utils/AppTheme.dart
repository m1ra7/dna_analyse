import 'package:flutter/material.dart';

// final themeProvider = Provider.of<ThemeProvider>(context);
// final isDark = themeProvider.isDarkMode;
//
// final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;

  //return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

double getSizeWith(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//? Sizes
final genisWitdh =
    double
        .infinity; //Flutter'da bir widget'a "mümkün olan maksimum genişliği kapla" demek.

BoxDecoration theme2 = BoxDecoration(
  // color: cardColor,
  borderRadius: BorderRadius.circular(16),
  boxShadow: [
    BoxShadow(
      //color: shadowColor,
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ],
);
BoxDecoration themeContainer = BoxDecoration(
  gradient:
      true
          ? const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF121212), Color(0xFF1E1E2D), Color(0xFF121212)],
          )
          : const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F7FF), Color(0xFFE8ECFF), Color(0xFFF5F7FF)],
          ),
);

//? Colors old
const Color white = Colors.white;
const Color black = Colors.black;
const Color black12 = Colors.black12;
const Color red = Colors.red;
const Color green = Colors.green;
const Color yellow = Colors.yellow;
const Color lightblue = Color(0xff00cbaff);
const Color dark = Color(0xFF0A0E21);
const Color dark2 = Color(0xFF1D1E33);
const Color dark3 = Color(0xFF0A0E21);
const Color wineRed = Color(0xFFEB1555);

const Color darkBackground = Color.fromARGB(255, 18, 18, 18);
const Color lightBackground = Color.fromARGB(255, 242, 245, 254);
const Color lightCardColor = Colors.white;
const Color lightFontColor = Color.fromARGB(255, 22, 63, 93);

final Container backgroundDark = Container(
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFF1D1E33), Color(0xFF0A0E21)],
    ),
  ),
);

List<Color> keyHealthMetricsColors = [
  Colors.red,
  Colors.purpleAccent,
  Colors.green,
  Colors.indigoAccent,
];

Color getProgressBarColor(int score) {
  if (score <= 39) return Colors.redAccent;
  if (score >= 40 && score <= 59) return Colors.yellow;
  if (score >= 60 && score <= 100) return Colors.green;
  return Colors.grey;
}

class CustomcardSide {
  final RoundedRectangleBorder cardSide = RoundedRectangleBorder(
    side: BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(15),
  ); // Kartın köşelerini yuvarlat),
}

final BoxDecoration customRadiusContainer = BoxDecoration(
  color: Color.fromARGB(255, 29, 27, 32),
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomLeft: Radius.circular(8.0),
    bottomRight: Radius.circular(8.0),
    topRight: Radius.circular(68.0),
  ),
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Color.fromARGB(255, 29, 27, 32),
      offset: Offset(1, 1),
      blurRadius: 1.0,
    ),
  ],
);

final BoxDecoration darkcustomRadiusContainer = BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomLeft: Radius.circular(8.0),
    bottomRight: Radius.circular(8.0),
    topRight: Radius.circular(68.0),
  ),
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      offset: Offset(1.1, 1.1),
      blurRadius: 10.0,
    ),
  ],
);

////////////? class

class AppTheme {
  AppTheme._();

  //? Colors
  static final Color _lightPrimaryColor = Colors.blueGrey.shade50;
  static final Color _lightPrimaryVariantColor = Colors.blueGrey.shade800;
  static final Color _lightOnPrimaryColor = Colors.blueGrey.shade200;
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Colors.white;
  static const Color _errorColor = Color(0xFFD32F2F);

  static final Color _darkPrimaryColor = Color(
    0xFF121212,
  ); //Colors.blueGrey.shade900;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static final Color _darkOnPrimaryColor = Colors.blueGrey.shade300;
  static const Color _darkTextColorPrimary = Colors.white;
  static final Color _appbarColorDark = const Color(0xFF121212);
  static final Color _appbarColorDark2 = Colors.blueGrey.shade800;

  static const Color _darkIconColor = Colors.white;
  static const Color _lightIconColor = Colors.black;

  //? TextStyle
  static const TextStyle _lightHeadingText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Montserrat",
  );

  static const TextStyle _lightBodyText = TextStyle(
    color: _lightTextColorPrimary,
    fontFamily: "Rubik",
    fontStyle: FontStyle.normal,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  static final TextStyle _darkThemeHeadingTextStyle = _lightHeadingText
      .copyWith(color: _darkTextColorPrimary);

  static final TextStyle _darkThemeBodyeTextStyle = _lightBodyText.copyWith(
    color: _darkTextColorPrimary,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkThemeHeadingTextStyle,
    bodyLarge: _darkThemeBodyeTextStyle,
  );

  //? Dark and Light Theme Color
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 1,
      color: _appbarColorLight,
      iconTheme: IconThemeData(color: _lightIconColor),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      primaryContainer: _lightPrimaryVariantColor,
      onError: _errorColor,
    ),
    textTheme: _lightTextTheme,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark, //nedir
    scaffoldBackgroundColor: _darkPrimaryColor,
    appBarTheme: AppBarTheme(
      color: _appbarColorDark,
      // backgroundColor:  _appbarColorDark,
      //Color(0xFF121212),
      iconTheme: const IconThemeData(color: _darkIconColor),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: _appbarColorDark),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightblue,
      selectedIconTheme: IconThemeData(color: white),
    ),
    // colorScheme: ColorScheme.dark(
    //    primary: _darkPrimaryColor,
    //   onPrimary: _darkOnPrimaryColor,
    //    primaryContainer: _darkPrimaryVariantColor,
    //   onError: _errorColor,
    // ),
    textTheme: _darkTextTheme,
    // cardTheme: CardTheme(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   color: Colors.grey[900],
    // ),
  );
}

//? Salomon Bar Selected Colors
class BottomColor {
  static final Color barItem1 = Colors.lightBlue;
  static final Color barItem2 = Colors.green;
  static final Color barItem3 = Colors.purpleAccent;
}

final ThemeData darkTheme2 = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity, ////
  //primarySwatch: Colors.indigo,
  //fontFamily: 'Inter',
  primaryColorDark: Colors.white,
  primaryColor: Colors.white,
  //scaffoldBackgroundColor: Colors.amber,
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      fontFamily: "Oswald", // Buraya istediğin fontu ekleyebilirsin
    ),
  ),

  /*textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          //canvasColor: Color.fromARGB(255, 16, 17, 20),*/
);
