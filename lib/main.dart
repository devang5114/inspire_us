import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:timezone/data/latest_all.dart';
import 'common/config/router/app_route_manager.dart';
import 'common/config/router/app_routes.dart';
import 'common/config/theme/app_theme.dart';
import 'common/config/theme/theme_export.dart';
import 'common/model/alarm_model.dart';
import 'common/model/day_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  initializeTimeZones();
  await initAwesomeNotifications();
  await Hive.initFlutter();
  await Hive.openBox('inspireUs');
  await Hive.openBox<AlarmModel>('alarm');
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(DayAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
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
  AwesomeNotifications().displayedStream.listen((notification) {
    NotificationRepository().playAlarm();
  });
  AwesomeNotifications().actionStream.listen((action) {
    if (action.buttonKeyPressed == 'SNOOZE') {
      NotificationRepository().stopAlarm();
    } else {
      NotificationRepository().stopAlarm();
    }
  });
  print(val);
}
