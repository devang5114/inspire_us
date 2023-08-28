import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';

import '../../../common/config/router/app_routes.dart';
import '../../../common/utils/constants/app_const.dart';

final loginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());

class LoginController extends ChangeNotifier {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpKey = GlobalKey<FormState>();

  bool keepSignIn = false;
  bool obsecure = true;
  bool loading = false;

  toggleObsecure() {
    obsecure = !obsecure;
    notifyListeners();
  }

  login(BuildContext context) async {
    if (loginKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      await Future.delayed(3.seconds);
      if (context.mounted) {
        context.pushAndRemoveUntilNamed(AppRoutes.confirmOtp);
      }

      loading = false;
      notifyListeners();
    }
  }

  verifyOtp(BuildContext context) async {
    if (otpKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      await Future.delayed(3.seconds);
      await LocalDb.localDb.putValue(isLoggedInKey, true);
      if (context.mounted) {
        context.pushAndRemoveUntilNamed(AppRoutes.dashboard);
      }

      loading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
