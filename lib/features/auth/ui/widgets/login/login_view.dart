import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../../../../common/utils/widgets/text_input.dart';
import '../../../controller/login_controller.dart';
import 'login_button.dart';
import '../../../../../common/utils/helper/validator.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginWatch = ref.watch(loginController);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
            color: Colors.white,
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
                    color: Colors.blueAccent,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600),
              ),
              TextInput(
                padding: EdgeInsets.only(bottom: 10.h),
                hintText: 'Email',
                validator: emailValidator,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.person,
                  size: 23.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.h),
              TextInput(
                obscureText: loginWatch.obsecure,
                padding: EdgeInsets.only(bottom: 10.h),
                hintText: 'Password',
                suffixIcon: obsecureIcon(ref),
                validator: passValidator,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 23.h,
                  color: Colors.grey,
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
