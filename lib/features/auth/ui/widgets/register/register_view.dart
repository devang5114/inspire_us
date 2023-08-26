import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/auth/ui/widgets/register/register_button.dart';

import '../../../../../common/utils/helper/validator.dart';
import '../../../../../common/utils/widgets/text_input.dart';
import '../../../controller/register_controller.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerWatch = ref.watch(registerController);

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
        child: SingleChildScrollView(
            child: Form(
          key: registerWatch.registerKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create your account',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600),
              ),
              TextInput(
                padding: EdgeInsets.only(bottom: 10.h),
                hintText: 'Name',
                validator: nameValidator,
                prefixIcon: Icon(
                  Icons.person,
                  size: 23.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20.h),
              TextInput(
                  padding: EdgeInsets.only(bottom: 10.h),
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: Text(
                      '@',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    color: Colors.grey,
                  )),
              SizedBox(height: 20.h),
              TextInput(
                padding: EdgeInsets.only(bottom: 10.h),
                obscureText: registerWatch.obsecure,
                suffixIcon: obsecureIcon(ref),
                hintText: 'Password',
                validator: passValidator,
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  size: 23.h,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30.h),
              const RegisterButton(),
            ],
          ),
        )),
      ),
    );
  }

  obsecureIcon(WidgetRef ref) {
    final registerWatch = ref.watch(registerController);
    return IconButton(
        onPressed: registerWatch.toggleObsecure,
        iconSize: 23.h,
        icon: Icon(
          registerWatch.obsecure ? Icons.visibility_off : Icons.visibility,
          color: registerWatch.obsecure ? Colors.grey : Colors.blueAccent,
        ));
  }
}
