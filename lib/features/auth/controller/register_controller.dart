import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../common/config/router/app_routes.dart';
import '../../../common/utils/constants/app_const.dart';
import '../../../common/utils/helper/local_database_helper.dart';

final registerController =
    ChangeNotifierProvider<RegisterController>((ref) => RegisterController());

class RegisterController extends ChangeNotifier {
  GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  bool termAndCond = false;
  bool obsecure = true;
  bool loading = false;

  toggleObsecure() {
    obsecure = !obsecure;
    notifyListeners();
  }

  register(BuildContext context) async {
    if (registerKey.currentState!.validate()) {
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
