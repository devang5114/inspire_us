import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/features/alarm/ui/screens/alarm_ring.dart';
import 'package:timezone/data/latest_all.dart';
import 'common/config/router/app_route_manager.dart';
import 'common/config/router/app_routes.dart';
import 'common/config/theme/app_theme.dart';
import 'common/config/theme/theme_export.dart';
import 'common/model/alarm_model.dart';
import 'common/model/day_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'common/utils/helper/network_state_helper.dart';
import 'features/alarm/repository/alarm_repository.dart';

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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              navigatorKey: navigationKey,
              darkTheme: AppTheme.darkTheme,
              themeMode: ref.watch(themeModeProvider),
              onGenerateRoute: AppRouteManager.onGenerateRoute,
              initialRoute: AppRoutes.splash,
            ));
  }
}

Future<void> initAwesomeNotifications() async {
  final val = await AwesomeNotifications()
      .initialize('resource://drawable/alarm_clock', [
    NotificationChannel(
        channelKey: 'schedule_channel',
        channelName: 'Schedule Alarms',
        playSound: true,
        enableVibration: true,
        channelDescription: 'This channel is used for schedule the alarms',
        defaultColor: Colors.blueAccent,
        importance: NotificationImportance.Max,
        channelShowBadge: true)
  ]);
  // AwesomeNotifications().displayedStream.listen((notification) {
  //   NotificationRepository().playAlarm();
  // });
  AwesomeNotifications().actionStream.listen((action) {
    if (action.buttonKeyPressed == 'SNOOZE') {
      MyApp.navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                AlarmRing(audioPath: action.body!, title: action.title ?? ''),
          ),
          (route) => false);
    }
  });
  print(val);
}
