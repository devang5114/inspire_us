import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/audio/ui/screens/audio.dart';
import 'package:inspire_us/features/home/ui/screens/home.dart';
import '../../../../common/config/theme/theme_manager.dart';
import '../../../alarm/ui/screens/alarm.dart';
import '../../../profile/ui/screens/profile.dart';
import '../../../recording/ui/screens/recording.dart';
import '../../controller/dashboard_controller.dart';
import '../widget/bottom_navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../common/common_repository/notification_repository.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this, initialIndex: 2);
    ref.read(notificationRepoProvider).requestPermission();
    ref.read(dashboardController).init(tabController);
  }

  @override
  void dispose() {
    close();
    tabController.dispose();
    super.dispose();
  }

  close() async {
    await Hive.box('alarm').close();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    final dashBoardWatch = ref.watch(dashboardController);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: isDarkMode ? Colors.black : Colors.white,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: SafeArea(
        child: DefaultTabController(
          length: 5,
          initialIndex: 2,
          child: Scaffold(
            body: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const Alarm().animate().fade(),
                const Audio().animate().fade(),
                const Home().animate().fade(),
                const Recording().animate().fade(),
                const Profile().animate().fade(),
              ],
            ),
            bottomNavigationBar: BottomNavBar(tabController),
          ),
        ),
      ),
    );
  }
}
