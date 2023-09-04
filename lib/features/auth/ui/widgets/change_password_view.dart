import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/auth/controller/register_controller.dart';

import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../../../common/utils/helper/validator.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../controller/login_controller.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
        child: SingleChildScrollView(
            child: Form(
          key: loginWatch.changePasswordKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Time to give your account an extra layer of security! Follow these easy steps to change your password',
                style: TextStyle(
                  color: context.colorScheme.onBackground,
                  fontSize: 15.sp,
                ),
              ).animate().fade(),
              SizedBox(height: 30.h),
              Text(
                'Change Password',
                style: TextStyle(
                    color: context.colorScheme.primary,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20.h),
              MyTextInput(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                hintText: 'Password',
                validator: passValidator,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                prefixIcon: Icon(
                  Icons.password_rounded,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
                onChange: (val) {
                  ref.read(loginController.notifier).changePassword = val;
                },
              ),
              SizedBox(height: 20.h),
              MyTextInput(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                ),
                hintText: 'Confirm Password',
                validator: (val) =>
                    confirmPassValidator(val, loginWatch.changePassword ?? ''),
                autoValidateMode: AutovalidateMode.onUserInteraction,
                prefixIcon: Icon(
                  Icons.password_rounded,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
                onChange: (val) {
                  ref.read(loginController.notifier).confirmChangePassword =
                      val;
                },
              ),
              SizedBox(height: 210.h),
              Button(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  backgroundColor: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(30.r),
                  onPressed: () {
                    ref
                        .read(loginController.notifier)
                        .changeUserPassword(context);
                  },
                  child: Text(
                    'Change password',
                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
