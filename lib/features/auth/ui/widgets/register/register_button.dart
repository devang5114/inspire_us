import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../../common/config/router/app_routes.dart';
import '../../../../../common/config/theme/theme_manager.dart';
import '../../../../../common/utils/widgets/button.dart';
import '../../../controller/register_controller.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerWatch = ref.watch(registerController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(30.r),
            onPressed: () {
              ref.read(registerController.notifier).register(context);
            },
            child: Text(
              'Sign up'.toUpperCase(),
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            )),
        SizedBox(height: 20.h),
        Row(
          children: [
            Checkbox.adaptive(
              activeColor: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)),
              value: registerWatch.termAndCond,
              onChanged: (value) {
                ref.read(registerController.notifier).termAndCond = value!;
                ref.read(registerController).notifyListeners();
              },
            ),
            RichText(
                text: TextSpan(
                    text: 'By tapping "Sign Up" you accept out \n',
                    style: TextStyle(
                        fontSize: 16.sp, color: Colors.grey, height: 1.5),
                    children: [
                  TextSpan(
                      text: 'terms ',
                      style: TextStyle(
                          fontSize: 16.sp, color: context.colorScheme.primary)),
                  TextSpan(
                      text: 'and ',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                  TextSpan(
                      text: 'Condition',
                      style: TextStyle(
                          fontSize: 15.sp, color: context.colorScheme.primary))
                ])),
          ],
        ),
        TextButton(
            onPressed: () {
              context.pushAndReplaceNamed(AppRoutes.login);
            },
            child: Text(
              "Already have an account",
              style: TextStyle(fontSize: 13.sp, color: Colors.blueAccent),
            )),
        SizedBox(height: 100.h),
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(30.r),
            onPressed: () {
              context.pushAndReplaceNamed(AppRoutes.login);
            },
            child: Text(
              'Sign in'.toUpperCase(),
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ))
      ],
    );
  }
}
