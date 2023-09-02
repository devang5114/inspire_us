import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/home/controller/home_controller.dart';
import 'package:inspire_us/features/home/ui/screens/search_screen.dart';

import '../../../../common/utils/helper/network_state_helper.dart';
import '../../../alarm/ui/widget/alarm_list.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    final time = ref.watch(homeController).getCurrentTime;
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    return Column(
      children: [
        const WarningWidgetValueNotifier(),
        OpenContainer(
          closedColor: Colors.transparent,
          closedElevation: 0,
          openElevation: 0,
          openColor: Colors.transparent,
          transitionDuration: 500.ms,
          closedBuilder: (context, action) {
            return InkWell(
              onTap: () {
                ref.read(homeController.notifier).getAlarmList();
                action.call();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 15.w, 16.h),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                  border: Border.all(
                      color: isDarkMode ? Colors.white : Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: context.colorScheme.onBackground,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'Search Alarm for Tagging',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
          openBuilder: (context, action) {
            return const Search();
          },
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: context.colorScheme.background,
              border: Border.all(
                  color: isDarkMode
                      ? context.colorScheme.primary
                      : Colors.grey.shade300,
                  width: 3.w),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: time.isNotEmpty
                ? Text(time,
                    style: TextStyle(
                        fontSize: 35.sp,
                        color: context.colorScheme.onBackground))
                : CircularProgressIndicator(
                    color: context.colorScheme.primary,
                  )),
        Expanded(
          child: const AlarmList(
            isHomePage: true,
          ),
        )
      ],
    );
  }
}
