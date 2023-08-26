import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest_all.dart';
import 'common/config/router/app_route_manager.dart';
import 'common/config/router/app_routes.dart';
import 'common/config/theme/app_theme.dart';
import 'common/config/theme/theme_export.dart';
import 'common/model/alarm_model.dart';
import 'common/model/day_model.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.blueAccent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  initializeTimeZones();
  // await initNotification();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  Hive.registerAdapter(DayAdapter());
  await Hive.openBox<AlarmModel>('alarm');
  runApp(const ProviderScope(child: MyApp()));
}
//
// Future<void> initNotification() async {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   const androidInitializationSettings =
//       AndroidInitializationSettings('app_icon');
//   const darwinInitializationSettings = DarwinInitializationSettings(
//     requestBadgePermission: true,
//     requestAlertPermission: true,
//     requestSoundPermission: true,
//     defaultPresentBadge: true,
//     defaultPresentSound: true,
//   );
//   const initializationSettings = InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: darwinInitializationSettings);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveBackgroundNotificationResponse:
//           onDidReceiveBackgroundNotificationResponse,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
// }
//
// onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
//   print('hii2');
// }
//
// onDidReceiveNotificationResponse(NotificationResponse response) {
//   print('hii');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              onGenerateRoute: AppRouteManager.onGenerateRoute,
              initialRoute: AppRoutes.splash,
            ));
  }
}
