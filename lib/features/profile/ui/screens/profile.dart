import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../widgets/profile_view.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20.sp,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.w600),
        )),
        body: const ProfileView());
  }
}
