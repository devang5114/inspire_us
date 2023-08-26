import 'package:hive_flutter/hive_flutter.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../../../common/model/alarm_model.dart';
import '../../../../common/utils/helper/local_database_helper.dart';
import '../alarm_tile.dart';

class AlarmList extends ConsumerWidget {
  const AlarmList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: ValueListenableBuilder<Box<AlarmModel>>(
      valueListenable: LocalDb.localDb.alarmBoxListenable,
      builder: (context, alarmBox, child) {
        if (alarmBox.values.isEmpty) {
          return const Center(
            child: Text('No Alarms Yet'),
          );
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
