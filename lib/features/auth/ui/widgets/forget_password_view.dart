import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/auth/controller/register_controller.dart';

import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../../../common/utils/helper/validator.dart';
import '../../controller/login_controller.dart';

class ForgetPasswordView extends ConsumerWidget {
  const ForgetPasswordView({super.key});

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
          key: loginWatch.forgetPasswordKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Oops, forgot your password? No worries, we're here to help you get back into your account.",
                style: TextStyle(
                  color: context.colorScheme.onBackground,
                  fontSize: 15.sp,
                ),
              ).animate().fade(),
              SizedBox(height: 30.h),
              Text(
                'Enter the email address you used to sign up',
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
                hintText: 'Enter email',
                validator: emailValidator,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.password,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
                onChange: (val) {
                  ref.read(loginController.notifier).forgetPasswordEmail = val;
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        )),
      ),
    );
  }
}
