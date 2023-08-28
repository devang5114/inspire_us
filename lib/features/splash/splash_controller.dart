import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/router/app_routes.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';

import '../../common/utils/constants/app_const.dart';

final splashController = ChangeNotifierProvider<SplashController>((ref) {
  return SplashController(ref);
});

class SplashController extends ChangeNotifier {
  SplashController(this.ref);
  Ref ref;

  init(BuildContext context) async {
    await Future.delayed(2.seconds);
    await setTheme();
    final isLoggedIn =
        await LocalDb.localDb.getValue(isLoggedInKey, defaultValue: false);

    if (isLoggedIn) {
      if (context.mounted) {
        context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
      }
    } else {
      if (context.mounted) {
        context.pushAndRemoveUntilNamed(AppRoutes.login);
      }
    }
  }

  setTheme() async {
    final isDarkModeActive = await LocalDb.localDb
        .getValue(isDarkModeActiveKey, defaultValue: false);
    if (isDarkModeActive) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
    } else {
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
    }
  }
}
