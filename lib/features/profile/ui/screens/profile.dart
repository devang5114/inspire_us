import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/loading.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/common/utils/widgets/busy_overlay.dart';
import 'package:inspire_us/features/profile/controller/profile_controller.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../widgets/profile_view.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  void initState() {
    super.initState();
    ref.read(profileController.notifier).init(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final profileWatch = ref.watch(profileController);

    return Scaffold(
        backgroundColor: context.colorScheme.background,
        appBar: AppBar(
            title: Text(
          'Profile',
          style: TextStyle(
              fontSize: 20.sp,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.w600),
        )),
        body: profileWatch.loading
            ? const Loading()
            : const Column(
                children: [
                  WarningWidgetValueNotifier(),
                  ProfileView(),
                ],
              ));
  }
}
