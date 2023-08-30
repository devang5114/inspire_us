import 'package:flutter/material.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/features/alarm/ui/screens/add_alarm.dart';
import 'package:inspire_us/features/auth/ui/screens/confirm_otp.dart';
import 'package:inspire_us/features/profile/ui/screens/profile_edit.dart';
import 'package:inspire_us/features/recording/ui/screens/my_recordings.dart';
import 'package:page_transition/page_transition.dart';

import '../../../features/alarm/ui/screens/alarm_ring.dart';
import '../../../features/auth/ui/screens/login.dart';
import '../../../features/auth/ui/screens/register.dart';
import '../../../features/dashboard/ui/screens/dashboard.dart';
import '../../../features/splash/splash.dart';
import 'app_routes.dart';

class AppRouteManager {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return PageTransition(
            child: const Splash(), type: PageTransitionType.fade);
      case AppRoutes.register:
        return PageTransition(
            child: const Register(), type: PageTransitionType.fade);
      case AppRoutes.confirmOtp:
        return PageTransition(
            child: const ConfirmOtp(), type: PageTransitionType.fade);
      case AppRoutes.login:
        return PageTransition(
            child: const Login(), type: PageTransitionType.fade);

      case AppRoutes.dashboard:
        return PageTransition(
            child: const DashBoard(), type: PageTransitionType.fade);
      // case AppRoutes.addAlarm:
      //   return PageTransition(
      //       child: AddAlarm(
      //           alarmModel: argument['alarmModel'], index: argument['index']),
      //       type: PageTransitionType.fade);

      // case AppRoutes.alarmRing:
      //   return PageTransition(
      //       child: const AlarmRing(), type: PageTransitionType.fade);
      case AppRoutes.editProfile:
        return PageTransition(
            child: const ProfileEdit(), type: PageTransitionType.rightToLeft);
      case AppRoutes.myRecording:
        return PageTransition(
            child: const MyRecordings(), type: PageTransitionType.rightToLeft);

      default:
        return MaterialPageRoute(
            builder: (context) => const Material(
                child: Center(child: Text('Something Went Wrong'))));
    }
  }
}
