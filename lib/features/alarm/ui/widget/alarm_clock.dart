import 'package:google_fonts/google_fonts.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../controller/alarm_controller.dart';

class AlarmClock extends ConsumerWidget {
  const AlarmClock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Theme(
      data: ThemeData.light().copyWith(
          useMaterial3: true,
          colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              secondary: Colors.blueAccent,
              onSecondary: Colors.white,
              error: Colors.redAccent,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.black,
              surface: Colors.grey,
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
          )),
      child: SizedBox(
        height: 500.h,
        width: context.screenWidth,
        child: FittedBox(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              ref.read(alarmController.notifier).pickTime(context);
            },
            child: IgnorePointer(
              child: ClipPath(
                clipper: CutClipper(),
                child: TimePickerDialog(
                    helpText: 'Tap to Select Time :',
                    cancelText: '',
                    confirmText: '',
                    initialTime: getInitialTime(ref)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TimeOfDay getInitialTime(WidgetRef ref) {
    final alarmWatch = ref.watch(alarmController);
    return TimeOfDay(
        hour: alarmWatch.alarmTime.hour, minute: alarmWatch.alarmTime.minute);
  }
}

class CutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final h = size.height;
    final w = size.width;
    return Path()
      ..lineTo(0, h * 0.85)
      ..lineTo(w, h * 0.85)
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
