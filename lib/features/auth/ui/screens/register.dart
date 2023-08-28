import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/utils/widgets/busy_overlay.dart';
import '../../controller/register_controller.dart';
import '../widgets/login/login_view.dart';
import '../widgets/register/register_view.dart';

class Register extends ConsumerWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return BusyOverlay(
      show: ref.watch(registerController).loading,
      child: GestureDetector(
        onTap: () => context.focusScope.unfocus(),
        child: Scaffold(
            backgroundColor: context.colorScheme.primary,
            body: Column(
              children: [
                SizedBox(height: 20.h),
                Container(
                  alignment: Alignment.center,
                  height: 170.h,
                  child: Text(
                    'Inspire Us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const RegisterView()
              ],
            )),
      ),
    );
  }
}
