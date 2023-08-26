import 'package:animations/animations.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../../alarm/controller/alarm_controller.dart';
import '../../../alarm/ui/screens/add_alarm.dart';

class AddFab extends ConsumerWidget {
  const AddFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OpenContainer(
      closedShape: const CircleBorder(),
      closedColor: Colors.blueAccent,
      openColor: Colors.blueAccent,
      transitionDuration: 500.ms,
      closedBuilder: (context, action) {
        return FloatingActionButton(
          enableFeedback: true,
          shape: const CircleBorder(),
          onPressed: () async {
            ref.read(alarmController.notifier).alarmTime = DateTime.now();
            action.call();
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
