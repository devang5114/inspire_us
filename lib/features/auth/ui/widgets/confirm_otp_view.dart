import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../../../common/utils/helper/validator.dart';
import '../../controller/login_controller.dart';

class ConfirmOtpView extends ConsumerWidget {
  const ConfirmOtpView({super.key});

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
          key: loginWatch.otpKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Email Verification code has been sent to your email Address',
                style: TextStyle(
                  color: context.colorScheme.onBackground,
                  fontSize: 15.sp,
                ),
              ).animate().fade(),
              SizedBox(height: 30.h),
              Text(
                'Confirm Your Otp',
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
                hintText: 'Enter otp',
                validator: (val) => nameValidator(val, isOtp: true),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.password,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        )),
      ),
    );
  }
}
