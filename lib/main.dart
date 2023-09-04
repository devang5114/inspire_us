import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/features/alarm/ui/screens/alarm_ring.dart';
import 'package:inspire_us/features/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart';
import 'common/config/router/app_route_manager.dart';
import 'common/config/router/app_routes.dart';
import 'common/config/theme/app_theme.dart';
import 'common/config/theme/theme_export.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'common/utils/helper/network_state_helper.dart';

final internetChecker = CheckInternetConnection();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  initializeTimeZones();
  await initAwesomeNotifications();
  await LocalDb.localDb.init();
  await FlutterDownloader.initialize(
    debug: true, // Set to false for production
  );
  final pref = await SharedPreferences.getInstance();
  String path = pref.getString('playingTune') ?? '';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ProviderScope(
        child: MyApp(
      path: path,
    )));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.path});
  final String path;

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              // navigatorKey: navigationKey,
              darkTheme: AppTheme.darkTheme,
              themeMode: ref.watch(themeModeProvider),
              onGenerateRoute: AppRouteManager.onGenerateRoute,
              // initialRoute: AppRoutes.splash,
              home: path != ''
                  ? AlarmRing(audioPath: path, title: 'Alarm is Ringing')
                  : const Splash(),
            ));
  }
}

Future<void> initAwesomeNotifications() async {
  final val = await AwesomeNotifications()
      .initialize('resource://drawable/alarm_clock', [
    NotificationChannel(
        channelKey: 'schedule_channel',
        channelName: 'Schedule Alarms',
        playSound: false,
        enableVibration: true,
        channelDescription: 'This channel is used for schedule the alarms',
        defaultColor: Colors.blueAccent,
        importance: NotificationImportance.Max,
        channelShowBadge: true)
  ]);
  // AwesomeNotifications().displayedStream.listen((notification) {
  //   NotificationRepository().playAlarm();
  // });
  // AwesomeNotifications().displayedStream.listen((event) {
  //   MyApp.navigationKey.currentState?.pushAndRemoveUntil(
  //       MaterialPageRoute(
  //         builder: (context) =>
  //             AlarmRing(audioPath: action.body!, title: action.title ?? ''),
  //       ),
  //       (route) => false);
  // });
  // AwesomeNotifications().actionStream.listen((action) {
  //   if (action.buttonKeyPressed == 'DisMiss') {
  //     MyApp.navigationKey.currentState?.pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               AlarmRing(audioPath: action.body!, title: action.title ?? ''),
  //         ),
  //         (route) => false);
  //   }
  // });
  print(val);
}
