import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../../common/config/router/app_routes.dart';
import '../../../../../common/utils/widgets/button.dart';
import '../../../controller/register_controller.dart';

class RegisterButton extends ConsumerWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerWatch = ref.watch(registerController);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: Colors.blueAccent,
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
              activeColor: Colors.blueAccent,
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
                      text: 'terms',
                      style: TextStyle(fontSize: 16.sp, color: Colors.blue)),
                  TextSpan(
                      text: 'and',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                  TextSpan(
                      text: 'Condition',
                      style: TextStyle(fontSize: 15.sp, color: Colors.blue))
                ])),
            // Text('BY tapping "Sign Up" you accept out ',
            //     style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
            // Text('BY tapping "Sign Up" you accept out ',
            //     style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
          ],
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              "Don't have an account",
              style: TextStyle(fontSize: 13.sp, color: Colors.blueAccent),
            )),
        SizedBox(height: 100.h),
        Button(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            backgroundColor: Colors.grey.shade200,
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
