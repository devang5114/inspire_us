import 'package:google_fonts/google_fonts.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      switchTheme: const SwitchThemeData(),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 20.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
          backgroundColor: Colors.transparent,
          elevation: 0),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
          secondary: Colors.blueAccent,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Colors.grey.shade100,
          onSurface: Colors.black),
      textTheme: GoogleFonts.aBeeZeeTextTheme(),
      timePickerTheme: TimePickerThemeData(
        dialBackgroundColor: Colors.blueAccent,
        elevation: 0,
        dayPeriodTextColor: Colors.black,
        hourMinuteTextStyle: TextStyle(fontSize: 40.sp),
        backgroundColor: Colors.white,
        dialTextColor: Colors.white,
        dialHandColor: Colors.black,
      ));

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      useMaterial3: true,
      listTileTheme: const ListTileThemeData(
        textColor: Colors.white,
      ),
      scaffoldBackgroundColor: Colors.black,
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.black))),
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.blueGrey,
          onPrimary: Colors.white,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.blueGrey.shade900,
          onSurface: Colors.white),
      textTheme: GoogleFonts.aBeeZeeTextTheme(),
      tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.blueGrey,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.blueGrey),
      timePickerTheme: TimePickerThemeData(
        dialBackgroundColor: Colors.blueGrey,
        elevation: 0,
        dayPeriodTextColor: Colors.white,
        hourMinuteTextStyle: TextStyle(fontSize: 40.sp),
        backgroundColor: Colors.black,
        dialTextColor: Colors.white,
        dialHandColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: Colors.blueGrey, width: 2),
        ),
        cancelButtonStyle: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.white)),
        confirmButtonStyle: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.resolveWith((states) => Colors.white)),
      ));
}
