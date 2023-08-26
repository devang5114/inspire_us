import 'package:google_fonts/google_fonts.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData.light().copyWith(
      useMaterial3: true,
      switchTheme: const SwitchThemeData(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
      ),
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

  static ThemeData darkTheme = ThemeData.dark();
}
