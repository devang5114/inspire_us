import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/constants/app_assets.dart';

import '../../controller/dashboard_controller.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar(this.tabController, {super.key});
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashBoardWatch = ref.watch(dashboardController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    return TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        onTap: (value) {
          ref.read(dashboardController.notifier).setPage(value);
        },
        indicatorWeight: 4.0,
        splashFactory: NoSplash.splashFactory,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
                color: isDarkMode ? Colors.blueGrey : Colors.blueAccent,
                width: 5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r))),
        tabs: [
          Tab(
            child: Image.asset(AppAssets.alarmClock,
                    height: 24.h,
                    width: 24.w,
                    color: dashBoardWatch.index == 0
                        ? isDarkMode
                            ? Colors.white
                            : Colors.blueAccent
                        : isDarkMode
                            ? Colors.grey
                            : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.recording,
                    height: 24.h,
                    width: 24.w,
                    color: dashBoardWatch.index == 1
                        ? isDarkMode
                            ? Colors.white
                            : Colors.blueAccent
                        : isDarkMode
                            ? Colors.grey
                            : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.homeIcon,
                    height: 24.h,
                    width: 24.w,
                    color: dashBoardWatch.index == 2
                        ? isDarkMode
                            ? Colors.white
                            : Colors.blueAccent
                        : isDarkMode
                            ? Colors.grey
                            : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.record,
                height: 24.h,
                width: 24.w,
                color: dashBoardWatch.index == 3
                    ? isDarkMode
                        ? Colors.white
                        : Colors.blueAccent
                    : isDarkMode
                        ? Colors.grey
                        : Colors.grey),
          ),
          Tab(
            child: Image.asset(AppAssets.userIcon,
                    height: 24.h,
                    width: 24.w,
                    color: dashBoardWatch.index == 4
                        ? isDarkMode
                            ? Colors.white
                            : Colors.blueAccent
                        : isDarkMode
                            ? Colors.grey
                            : Colors.grey)
                .animate()
                .fade(),
          ),
        ]);
  }
}
