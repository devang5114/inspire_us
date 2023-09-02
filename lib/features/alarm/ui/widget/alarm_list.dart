import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/alarm/ui/widget/alarm_tile.dart';

import '../../../../common/model/alarm_model.dart';
import '../../../../common/utils/helper/local_database_helper.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../../dashboard/controller/dashboard_controller.dart';

class AlarmList extends ConsumerWidget {
  const AlarmList({this.isHomePage = false, super.key});
  final bool isHomePage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: ValueListenableBuilder<Box<AlarmModel>>(
        valueListenable: LocalDb.localDb.alarmBoxListenable,
        builder: (context, alarmBox, child) {
          List<AlarmModel> alarmList = alarmBox.values.toList();
          List<int> reversedIndices =
              List.generate(alarmList.length, (index) => index);

          // Reverse the indices
          reversedIndices = reversedIndices.reversed.toList();

          if (alarmList.isEmpty) {
            return Center(
              child: isHomePage
                  ? Button(
                      backgroundColor: context.colorScheme.primary,
                      child: Text(
                        'Add New Alarm',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      onPressed: () {
                        ref.read(dashboardController.notifier).setPage(0);
                      },
                    )
                  : Text(
                      'Click On + button to add ⏰ Alarm',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: context.colorScheme.onBackground,
                      ),
                    ),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: alarmList.length,
              itemBuilder: (context, index) {
                AlarmModel alarmModel = alarmList[reversedIndices[index]];
                return AlarmTile(
                  alarmModel: alarmModel,
                  index: reversedIndices[index],
                );
              },
            );
          }
        },
      ),
    );
  }
}
