import 'package:animations/animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/router/app_routes.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/alarm/ui/alarm_tile.dart';
import 'package:inspire_us/features/alarm/ui/screens/add_alarm.dart';
import 'package:intl/intl.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/utils/helper/local_database_helper.dart';
import '../../../alarm/controller/alarm_controller.dart';

class Search extends ConsumerWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final timeFormater = DateFormat('hh:mm a');

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 30.h),
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 0.h, 15.w, 0.h),
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
                  Expanded(
                    child: MyTextInput(
                      borderInputNone: true,
                      hintText: 'Search Alarm for Tagging',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ValueListenableBuilder<Box<AlarmModel>>(
                    valueListenable: LocalDb.localDb.alarmBoxListenable,
                    builder: (context, alarmBox, child) {
                      if (alarmBox.values.isEmpty) {
                        return const Center(child: Text('No Alarms Taged'));
                      }
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        separatorBuilder: (context, index) => Divider(
                          color: context.colorScheme.surface,
                          height: 3.h,
                          thickness: 3,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: alarmBox.length,
                        itemBuilder: (context, index) {
                          AlarmModel alarmModel = alarmBox.getAt(index)!;
                          return OpenContainer(
                            closedElevation: 0,
                            openElevation: 0,
                            openBuilder: (context, action) {
                              return AddAlarm(
                                index: index,
                                alarmModel: alarmModel,
                              );
                            },
                            closedBuilder: (context, action) {
                              return ListTile(
                                onTap: () {
                                  context.pop();
                                  action.call();
                                },
                                  <key>NSMicrophoneUsageDescription</key>
                              <string>We need access to the microphone for audio recording.</string>
                                title: Text(
                                    alarmModel.label.isEmpty
                                        ? 'Alarm'
                                        : alarmModel.label,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color:
                                            context.colorScheme.onBackground)),
                                subtitle: Text(
                                  timeFormater.format(alarmModel.time),
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.grey),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
