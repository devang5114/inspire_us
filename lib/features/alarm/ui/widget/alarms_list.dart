import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/features/dashboard/controller/dashboard_controller.dart';

import '../../../../common/model/alarm_model.dart';
import '../../../../common/utils/helper/local_database_helper.dart';
import '../alarm_tile.dart';

class AlarmList extends ConsumerWidget {
  const AlarmList({this.isHomePage = false, super.key});
  final bool isHomePage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: ValueListenableBuilder<Box<AlarmModel>>(
      valueListenable: LocalDb.localDb.alarmBoxListenable,
      builder: (context, alarmBox, child) {
        if (alarmBox.values.isEmpty) {
          return Center(
              child: isHomePage
                  ? Button(
                      backgroundColor: context.colorScheme.primary,
                      child: Text(
                        'Add New Alarm',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onPrimary),
                      ),
                      onPressed: () {
                        ref.read(dashboardController.notifier).setPage(0);
                      })
                  : Text(
                      'Click On + button to add ⏰ Alarm',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onSurface),
                    ));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: alarmBox.length,
            itemBuilder: (context, index) {
              AlarmModel alarmModel = alarmBox.getAt(index)!;
              return AlarmTile(
                alarmModel: alarmModel,
                index: index,
              );
            },
          );
        }
      },
    ));
  }
}
