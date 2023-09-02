import 'package:flutter/services.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/auth/controller/register_controller.dart';

import '../../../../common/utils/widgets/busy_overlay.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../controller/login_controller.dart';
import '../widgets/change_password_view.dart';
import '../widgets/confirm_otp_view.dart';
import '../widgets/login/login_view.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    // final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: context.colorScheme.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: BusyOverlay(
        show: loginWatch.loading,
        child: GestureDetector(
          onTap: () => context.focusScope.unfocus(),
          child: Scaffold(
            backgroundColor: context.colorScheme.primary,
            body: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.center,
                  height: 170.h,
                  child: Text(
                    'Inspire Us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const ChangePasswordView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
