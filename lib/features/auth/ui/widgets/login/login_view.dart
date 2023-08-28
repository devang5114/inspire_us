import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../controller/login_controller.dart';
import 'login_button.dart';
import '../../../../../common/utils/helper/validator.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

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
          key: loginWatch.loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                    color: context.colorScheme.primary,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600),
              ),
              MyTextInput(
                padding: EdgeInsets.only(bottom: 10.h),
                hintText: 'Email',
                validator: emailValidator,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.person,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
              SizedBox(height: 20.h),
              MyTextInput(
                obscureText: loginWatch.obsecure,
                padding: EdgeInsets.only(bottom: 10.h),
                hintText: 'Password',
                suffixIcon: obsecureIcon(ref),
                validator: passValidator,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 23.h,
                  color: isDarkMode ? Colors.white : Colors.grey,
                ),
              ),
              SizedBox(height: 30.h),
              const LoginButton(),
            ],
          ),
        )),
      ),
    );
  }

  obsecureIcon(WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    return IconButton(
        onPressed: loginWatch.toggleObsecure,
        iconSize: 23.h,
        icon: Icon(
          loginWatch.obsecure ? Icons.visibility_off : Icons.visibility,
          color: loginWatch.obsecure ? Colors.grey : Colors.blueAccent,
        ));
  }
}
