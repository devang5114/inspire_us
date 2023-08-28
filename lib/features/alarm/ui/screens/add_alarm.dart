import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../controller/alarm_controller.dart';
import '../widget/alarm_clock.dart';
import '../widget/alarm_view.dart';

class AddAlarm extends ConsumerStatefulWidget {
  const AddAlarm({super.key, this.alarmModel, this.index});
  final AlarmModel? alarmModel;
  final int? index;

  @override
  ConsumerState<AddAlarm> createState() => _AddAlarmState();
}

class _AddAlarmState extends ConsumerState<AddAlarm> {
  @override
  void initState() {
    super.initState();
    if (widget.alarmModel != null) {
      ref
          .read(alarmController.notifier)
          .update(widget.alarmModel!, widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        ref.read(alarmController).reset();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.background,
        body: const SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [AlarmClock(), AlarmView()],
            ),
          ),
        ),
      ),
    );
  }
}
