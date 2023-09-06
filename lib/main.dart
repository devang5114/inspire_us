import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
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
  final alarm = await getActiveAlarm();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ProviderScope(
        child: MyApp(
      activeAlarm: alarm,
    )));
  });
}

Future<AlarmModel?> getActiveAlarm() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final id = pref.getString('activeAlarmId');
  if (id == null) return null;

  try {
    final alarm = LocalDb.localDb.alarmBox!.values.firstWhere((element) {
      return element.id == int.parse(id);
    });
    return alarm;
  } catch (e) {
    return null;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, this.activeAlarm});
  final AlarmModel? activeAlarm;

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
              home: activeAlarm != null
                  ? AlarmRing(activeAlarmModel: activeAlarm!)
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
        defaultRingtoneType: DefaultRingtoneType.Alarm,
        channelDescription: 'This channel is used for schedule the alarms',
        defaultColor: Colors.blueAccent,
        importance: NotificationImportance.High,
        defaultPrivacy: NotificationPrivacy.Public,
        channelShowBadge: true)
  ]);
  AwesomeNotifications().createdStream.listen((notification) async {
    print('Display stream entry');
    if (notification.channelKey == 'schedule_channel') {
      print('Display stream entry');
      final id = int.parse(notification.payload!['alarmId']!);
      print('alarm Id for stream $id');
      final alarmModel = LocalDb.localDb.alarmBox!.values
          .firstWhere((element) => element.id == id);
      MyApp.navigationKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return AlarmRing(
              isAppActive: true,
              activeAlarmModel: alarmModel,
            );
          },
        ),
        (route) => false,
      );
    }
  });
  print(val);
}
