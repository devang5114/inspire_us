import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../common/config/router/app_routes.dart';
import '../../common/utils/constants/app_assets.dart';
import '../alarm/repository/alarm_repository.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({super.key});

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // await ref.read(alarmRepoProvider).initNotification();
    await ref.read(alarmRepoProvider).requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(3.seconds, () {
      context.pushAndReplaceNamed(AppRoutes.login);
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
              AppAssets.splash,
            ))),
            height: 600.h,
            width: 600.w,
          ),
        ),
      ),
    );
  }
}
