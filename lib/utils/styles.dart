import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
// hexSting format #FFFFFF
  static Color parseColor(String hexString) {
    try {
      return Color(int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000);
    } catch (e) {
      return Colors.orange;
    }
  }

// hexSting format #FFFFFF
  static int parseColorInt(String hexString) {
    try {
      return int.parse(hexString.replaceFirst('#', '0x')) + 0xFF000000;
    } catch (e) {
      return 0xFF121212;
    }
  }

  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );

  static Map<int, Color> getColorSwatch(Color color) {
    return {
      50: Color.fromRGBO(color.red, color.green, color.blue, .1),
      100: Color.fromRGBO(color.red, color.green, color.blue, .2),
      200: Color.fromRGBO(color.red, color.green, color.blue, .3),
      300: Color.fromRGBO(color.red, color.green, color.blue, .4),
      400: Color.fromRGBO(color.red, color.green, color.blue, .5),
      500: Color.fromRGBO(color.red, color.green, color.blue, .6),
      600: Color.fromRGBO(color.red, color.green, color.blue, .7),
      700: Color.fromRGBO(color.red, color.green, color.blue, .8),
      800: Color.fromRGBO(color.red, color.green, color.blue, .9),
      900: Color.fromRGBO(color.red, color.green, color.blue, 1),
    };
  }

  static bool isDarkThemeEnabled(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  EdgeInsets defaultPadding() => EdgeInsets.fromLTRB(12, 8, 12, 0);

  void removeFocusFromInputField(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static ThemeData darkTheme() {
    return ThemeData(
      // brightness: Brightness.dark,
      // primarySwatch: MaterialColor(
      //   // parseColorInt(model.appLandingData.primaryThemeColor),
      //   // getColorSwatch(parseColor(model.appLandingData.primaryThemeColor)),
      // ),
      // primaryColor: getColorSwatch(
      //   Colors.black54.withOpacity(0.7),

      //   // parseColor(model.appLandingData.primaryThemeColor)
      // )[900],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Color(0xFF2A2D2E),
      fontFamily: 'Montserrat',
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.8),
        ),

        // parseColor(model.appLandingData.topBarTextColor)),
        titleTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.sp,
          color: Colors.white.withOpacity(0.8),

          // color: parseColor(model.appLandingData.topBarTextColor),
        ),
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 22.sp,
            ),
            subtitle1: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            subtitle2: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
            bodyText1: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
            bodyText2: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
            button: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.sp,
            ),
            labelMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
      focusColor: Color(0xFF2A2D2E),
      splashColor: Colors.white,
      canvasColor: Color(0xff585959),
      indicatorColor: Color(0xFFFFFFFF),
      dividerColor: Color(0xFFFFFFFF),
      backgroundColor: Color(0xFF2A2D2E),
      cardColor: Colors.grey.withOpacity(0.3),
      shadowColor: Color(0xFF2A2D2E).withOpacity(0.1),
      iconTheme: IconThemeData(color: Colors.white, size: 24, opacity: 0.4),
      primaryIconTheme: ThemeData.dark().primaryIconTheme.copyWith(
            color: Color(0xFF2A2D2E),

            // parseColor(model.appLandingData.topBarTextColor),
          ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF2A2D2E),
        // parseColor(model.appLandingData.bottomBarBackgroundColor),
        elevation: 10,
        selectedItemColor: Color(0xFF2A2D2E),

        // parseColor(
        //     model.appLandingData.bottomBarActiveColor), // Need to set from api
        unselectedItemColor: Colors.white.withOpacity(0.8),

        // parseColor(model
        //     .appLandingData.bottomBarInactiveColor), // Need to set from api
        showUnselectedLabels: true,
      ),
      toggleableActiveColor: Colors.white.withOpacity(0.9),
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(secondary: Color(0xff6A6B6B), brightness: Brightness.dark),

      // getColorSwatch(parseColor(model.appLandingData.primaryThemeColor))[
      //     900], // checked checkbox color
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      // primarySwatch: MaterialColor(
      //   // parseColorInt(model.appLandingData.primaryThemeColor),
      //   // getColorSwatch(parseColor(model.appLandingData.primaryThemeColor)),
      // ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Color(0xFFF1F1F2),
      fontFamily: 'Montserrat',

      appBarTheme: AppBarTheme(
        // iconTheme: IconThemeData(color: Color(0xFFF1F1F2)),
        // parseColor(model.appLandingData.topBarTextColor)),
        titleTextStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20.sp,
          color: Colors.black54.withOpacity(0.6),

          // color: parseColor(model.appLandingData.topBarTextColor),
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey[600],
              fontSize: 22.sp,
            ),
            subtitle1: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.grey[600],
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            subtitle2: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600),
            bodyText1: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
            bodyText2: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
            button: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15.sp,
            ),
            labelMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500),
          ),
      splashColor: Colors.black,
      focusColor: Colors.white,
      canvasColor: Colors.white,
      // cursorColor: Color(0xFF2A2D2E),
      indicatorColor: Color(0xFF000000),
      backgroundColor: Colors.white,
      //  Color(0xFFF1F1F2),
      // backgroundColor: Color(0xFFCC0B00),
      dividerColor: Color(0xff254180),
      //  Color(0xff1164AA),
      cardColor: Color(0xFFFFFFFF),
      shadowColor: Colors.grey.withOpacity(0.4),
      iconTheme: IconThemeData(color: Colors.black, size: 24, opacity: 0.7),
      primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
            // AppBar icon color
            // color: parseColor(model.appLandingData.topBarTextColor),
            color: Color(0xF1F1F2),
          ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        //  Color(0xFFF1F1F2),
        // parseColor(model.appLandingData.bottomBarBackgroundColor),
        elevation: 10,
        selectedItemColor: Colors.blue.withOpacity(0.8),

        // parseColor(
        //     model.appLandingData.bottomBarActiveColor), // Need to set from api
        unselectedItemColor: Colors.grey.withOpacity(0.8),

        // parseColor(model
        // .appLandingData.bottomBarInactiveColor), // Need to set from api
        showUnselectedLabels: true,
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Color(0xffE6E7E8)),
    );
  }

  TextStyle? bodyText14(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        );
  }

  TextStyle? bodyText16(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        );
  }

  TextStyle? bodyText12(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).primaryColor,
        );
  }

  TextStyle? bodyText22(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        );
  }

  static Color secondaryButtonColor = Color(0x2B2E43 + 0xFF000000);

  static TextStyle productNameTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 17.0,
        );
  }

  static TextStyle productPriceTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        );
  }

  static Color? textColor(BuildContext context) {
    return isDarkThemeEnabled(context) ? Colors.grey[200] : Colors.grey[800];
  }
}
