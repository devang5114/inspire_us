import 'package:flutter_svg/flutter_svg.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/dashboard/ui/widget/add_fab.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../widget/alarms_list.dart';

class Alarm extends ConsumerWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Alarm Taging',
          style: TextStyle(
              fontSize: 20.sp,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const AlarmList(),
          SizedBox(height: 10.h),
        ],
      ),
      floatingActionButton: const AddFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
