import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/auth/repository/auth_repository.dart';
import 'package:inspire_us/features/auth/ui/screens/confirm_otp.dart';

import '../../../common/config/router/app_routes.dart';
import '../../../common/utils/constants/app_const.dart';
import '../../../common/utils/helper/local_database_helper.dart';

final registerController = ChangeNotifierProvider<RegisterController>(
    (ref) => RegisterController(ref));

class RegisterController extends ChangeNotifier {
  RegisterController(this.ref);
  Ref ref;
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  String? name;
  String? email;
  String? otp;
  String? password;
  int? registerCode;
  bool termAndCond = false;
  bool obsecure = true;
  bool loading = false;

  toggleObsecure() {
    obsecure = !obsecure;
    notifyListeners();
  }

  register(BuildContext context) async {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    if (registerKey.currentState!.validate()) {
      if (!termAndCond) {
        Fluttertoast.showToast(msg: 'Please Accept terms and Conditions');
        return;
      }
      loading = true;
      notifyListeners();
      final authResponse = await ref
          .read(authRepoProvider)
          .registerRequest(name!, email!, password!);
      if (authResponse.registerCode != null && authResponse.authToken != null) {
        await LocalDb.localDb.putValue(authTokenKey, authResponse.authToken);
        registerCode = authResponse.registerCode;
        if (context.mounted) {
          context.push(const ConfirmOtp(otpType: OtpType.emailVerify));
        }
      } else {
        Fluttertoast.showToast(
            msg: authResponse.error!,
            gravity: ToastGravity.CENTER,
            textColor: isDarkMode ? Colors.black : Colors.white,
            backgroundColor: isDarkMode ? Colors.white : Colors.black);
      }
      loading = false;
      notifyListeners();
    }
  }

  verifyOtp(BuildContext context) async {
    if (otp != null) {
      if (otp != registerCode.toString()) {
        Fluttertoast.showToast(
            msg: 'Otp does Not match',
            gravity: ToastGravity.CENTER,
            textColor: context.colorScheme.background,
            backgroundColor: context.colorScheme.onBackground);
        return;
      }
      loading = true;
      notifyListeners();
      final authResponse = await ref
          .read(authRepoProvider)
          .verifyEmail(email!, registerCode.toString());
      if (authResponse.isEmailVerified != null) {
        if (authResponse.isEmailVerified!) {
          Fluttertoast.showToast(
              msg: 'Email Verified..',
              gravity: ToastGravity.CENTER,
              textColor: context.colorScheme.background,
              backgroundColor: context.colorScheme.onBackground);
          if (context.mounted) {
            context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
          } else {
            Fluttertoast.showToast(
                msg: 'Verification fail',
                textColor: context.colorScheme.background,
                backgroundColor: context.colorScheme.onBackground,
                gravity: ToastGravity.CENTER);
          }
        }
      } else {
        Fluttertoast.showToast(
            msg: authResponse.error!,
            gravity: ToastGravity.CENTER,
            textColor: context.colorScheme.background,
            backgroundColor: context.colorScheme.onBackground);
      }

      loading = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
          msg: 'Plz enter valid otp',
          gravity: ToastGravity.CENTER,
          textColor: context.colorScheme.background,
          backgroundColor: context.colorScheme.onBackground);
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
