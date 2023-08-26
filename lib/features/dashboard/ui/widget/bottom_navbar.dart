import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/constants/app_assets.dart';

import '../../controller/dashboard_controller.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar(this.tabController, {super.key});
  final TabController tabController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashBoardWatch = ref.watch(dashboardController);
    return TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 4.0,
        splashFactory: NoSplash.splashFactory,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
        indicatorColor: Colors.blueAccent,
        indicator: UnderlineTabIndicator(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 5),
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r))),
        tabs: [
          Tab(
            child: Image.asset(AppAssets.alarmClock,
                    height: 24.h,
                    width: 24.w,
                    color:
                        dashBoardWatch.index == 0 ? Colors.black : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.recording,
                    height: 24.h,
                    width: 24.w,
                    color:
                        dashBoardWatch.index == 1 ? Colors.black : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.homeIcon,
                    height: 24.h,
                    width: 24.w,
                    color:
                        dashBoardWatch.index == 2 ? Colors.black : Colors.grey)
                .animate()
                .fade(),
          ),
          Tab(
            child: Image.asset(AppAssets.record,
                height: 24.h,
                width: 24.w,
                color: dashBoardWatch.index == 3 ? Colors.black : Colors.grey),
          ),
          Tab(
            child: Image.asset(AppAssets.userIcon,
                    height: 24.h,
                    width: 24.w,
                    color:
                        dashBoardWatch.index == 4 ? Colors.black : Colors.grey)
                .animate()
                .fade(),
          ),
        ]);
  }
}
