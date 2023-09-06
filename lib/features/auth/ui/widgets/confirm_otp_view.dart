import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/auth/controller/register_controller.dart';
import 'package:pinput/pinput.dart';

import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../../../common/utils/helper/validator.dart';
import '../../../../common/utils/constants/enums.dart';
import '../../controller/login_controller.dart';

class ConfirmOtpView extends ConsumerWidget {
  const ConfirmOtpView({required this.otpType, super.key});
  final OtpType otpType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isEmailVerifyOtp = otpType == OtpType.emailVerify;
    //
    // final registerWatch = ref.watch(registerController);
    // final loginWatch = ref.watch(loginController);

    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
            color: context.colorScheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isEmailVerifyOtp
                  ? 'Email Verification code has been sent to your email Address'
                  : 'Please enter the OTP code sent to your email',
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
            Pinput(
              length: 6,
              onCompleted: (value) {
                if (isEmailVerifyOtp) {
                  ref.read(registerController.notifier).otp = value;
                } else {
                  ref.read(loginController.notifier).otp = value;
                }
              },
            ),
            SizedBox(height: 30.h),
          ],
        )),
      ),
    );
  }
}
