import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../../common/config/router/app_routes.dart';
import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/button.dart';
import '../../../controller/login_controller.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(30.r),
            onPressed: () {
              ref.read(loginController.notifier).login(context);
            },
            child: Text(
              'Sign In'.toUpperCase(),
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            )),
        SizedBox(height: 10.h),
        Row(
          children: [
            Checkbox.adaptive(
              activeColor: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)),
              value: loginWatch.keepSignIn,
              onChanged: (value) {
                ref.read(loginController.notifier).keepSignIn = value!;
                ref.read(loginController).notifyListeners();
              },
            ),
            Text('Keep Sign In',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
          ],
        ),
        TextButton(
            onPressed: () {
              context.pushAndReplaceNamed(AppRoutes.register);
            },
            child: Text(
              "Don't have an account",
              style: TextStyle(fontSize: 13.sp, color: Colors.blueAccent),
            )),
        SizedBox(height: 150.h),
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(30.r),
            onPressed: () {
              context.pushAndReplaceNamed(AppRoutes.register);
            },
            child: Text(
              'Create an account'.toUpperCase(),
              style: TextStyle(
                  fontSize: 15.sp,
                  color: isDarkMode ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
