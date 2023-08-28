import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/splash/splash_controller.dart';

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
    ref.read(splashController).init(context);
  }

  @override
  Widget build(BuildContext context) {
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
            height: 300.h,
            width: 300.w,
          ),
        ),
      ),
    );
  }
}
