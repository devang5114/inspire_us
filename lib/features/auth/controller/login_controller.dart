import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/common_repository/api_repositoy.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/features/alarm/repository/alarm_api_reposioty.dart';
import 'package:inspire_us/features/auth/repository/auth_repository.dart';
import 'package:inspire_us/features/auth/ui/screens/confirm_otp.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../common/config/router/app_routes.dart';
import '../../../common/utils/constants/app_const.dart';
import '../../alarm/repository/alarm_repository.dart';

final loginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController(ref));

class LoginController extends ChangeNotifier {
  LoginController(this.ref);

  Ref ref;
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgetPasswordKey = GlobalKey<FormState>();
  GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? forgetPasswordEmail;
  String? forgetPasswordOtp;
  String? otp;

  String? changePassword;
  String? confirmChangePassword;

  bool keepSignIn = false;
  bool obsecure = true;
  bool loading = false;

  toggleObsecure() {
    obsecure = !obsecure;
    notifyListeners();
  }

  login(BuildContext context) async {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    if (loginKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final authResponse =
          await ref.read(authRepoProvider).loginRequest(email!, password!);
      print(authResponse);
      if (authResponse.authToken != null) {
        AlarmRepository.synchronizeAlarms(ref);
        await LocalDb.localDb.putValue(authTokenKey, authResponse.authToken);
        Fluttertoast.showToast(
            msg: 'Login Successfully',
            gravity: ToastGravity.CENTER,
            textColor: isDarkMode ? Colors.black : Colors.white,
            backgroundColor: isDarkMode ? Colors.white : Colors.black);
        await AlarmRepository.synchronizeAlarms(ref);
        if (context.mounted) {
          context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
        }
      } else {
        Fluttertoast.showToast(
            msg: authResponse.error!,
            gravity: ToastGravity.SNACKBAR,
            textColor: isDarkMode ? Colors.black : Colors.white,
            backgroundColor: isDarkMode ? Colors.white : Colors.black);
      }

      loading = false;
      notifyListeners();
    }
  }

  logOut(BuildContext context) {
    LocalDb.localDb.putValue(authTokenKey, null);
    LocalDb.localDb.putValue(userIdKey, null);
    context.pushAndRemoveUntilNamed(AppRoutes.login);
  }

  forgetPassword(BuildContext context) async {
    if (forgetPasswordKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final authResponse =
          await ref.read(authRepoProvider).forgetPassword(forgetPasswordEmail!);
      if (authResponse.forgetPassWordOtp != null) {
        forgetPasswordOtp = authResponse.forgetPassWordOtp!.toString();
        context.push(const ConfirmOtp(otpType: OtpType.forgetPassword));
        Fluttertoast.showToast(
            msg: 'Otp sent to $forgetPasswordEmail',
            backgroundColor: context.colorScheme.onBackground,
            textColor: context.colorScheme.background);
      } else {
        Fluttertoast.showToast(
            msg: authResponse.error ?? 'Plz try again',
            backgroundColor: context.colorScheme.onBackground,
            textColor: context.colorScheme.background);
      }
      loading = false;
      notifyListeners();
    }
  }

  changeUserPassword(BuildContext context) async {
    if (changePasswordKey.currentState!.validate()) {
      loading = true;
      notifyListeners();

      final authResponse = await ref
          .read(authRepoProvider)
          .changePassWord(forgetPasswordEmail!, changePassword!);
      if (authResponse.successMessage != null) {
        print(authResponse);
        Fluttertoast.showToast(
            msg: authResponse.successMessage!,
            backgroundColor: context.colorScheme.onBackground,
            textColor: context.colorScheme.background);
        context.pushAndRemoveUntilNamed(AppRoutes.login);
      } else {
        Fluttertoast.showToast(
            msg: authResponse.error!,
            backgroundColor: context.colorScheme.onBackground,
            textColor: context.colorScheme.background);
      }
      loading = false;
      notifyListeners();
    }
  }

  verifyOtp(BuildContext context) async {
    if (otp != null) {
      if (otp != forgetPasswordOtp.toString()) {
        Fluttertoast.showToast(
            msg: 'Otp does Not match',
            gravity: ToastGravity.CENTER,
            textColor: context.colorScheme.background,
            backgroundColor: context.colorScheme.onBackground);
        return;
      }
      Fluttertoast.showToast(
          msg: 'Otp Verified..',
          gravity: ToastGravity.CENTER,
          textColor: context.colorScheme.background,
          backgroundColor: context.colorScheme.onBackground);
      context.pushAndRemoveUntilNamed(AppRoutes.changePassword);
    } else {
      Fluttertoast.showToast(
          msg: 'Plz Enter valid otp',
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
