import 'package:animations/animations.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/main.dart';

import '../../../../common/common_repository/notification_repository.dart';
import '../../../alarm/controller/alarm_controller.dart';
import '../../../alarm/ui/screens/add_alarm.dart';

class AddFab extends ConsumerWidget {
  const AddFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OpenContainer(
      closedShape: const CircleBorder(),
      closedColor: context.colorScheme.primary,
      openColor: context.colorScheme.primary,
      transitionDuration: 500.ms,
      closedBuilder: (context, action) {
        return FloatingActionButton(
          enableFeedback: true,
          shape: const CircleBorder(),
          onPressed: () async {
            // ref.read(notificationRepoProvider).showSimpleNotification();
            print(ref.watch(networkStateProvider));
            if (ref.watch(networkStateProvider) == NetworkState.online) {
              ref.read(alarmController.notifier).alarmTime = DateTime.now();
              action.call();
            } else {
              Fluttertoast.showToast(msg: 'You are offline');
            }
          },
          child: const Icon(Icons.alarm_add_outlined),
        );
      },
      openBuilder: (context, action) {
        return const AddAlarm();
      },
    );
  }

  playTune() async {
    await FlutterRingtonePlayer.playNotification();
  }
}
