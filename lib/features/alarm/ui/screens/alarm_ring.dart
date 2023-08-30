import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../common/config/router/app_routes.dart';

class AlarmRing extends StatelessWidget {
  const AlarmRing({super.key, required this.audioPath, required this.title});
  final String audioPath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Alarm is Ringing $alarmShowTime'),
          ElevatedButton(
              onPressed: () async {
                AudioPlayer audioPlayer = AudioPlayer();
                await audioPlayer.setUrl(audioPath);
                audioPlayer.stop();
              },
              child: const Text('Stop')),
        ],
      ),
    ));
  }
}
