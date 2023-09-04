import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/config/router/app_routes.dart';

class AlarmRing extends StatefulWidget {
  const AlarmRing({super.key, required this.audioPath, required this.title});
  final String audioPath;
  final String title;

  @override
  State<AlarmRing> createState() => _AlarmRingState();
}

class _AlarmRingState extends State<AlarmRing> {
  @override
  void initState() {
    super.initState();
    // audioPlayer = AudioPlayer()..setFilePath(widget.audioPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Alarm is Ringing $alarmShowTime'),
          const Text('Alarm is Ringing'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.setString('playingTune', '');

                    exit(0);
                    // audioPlayer.play();
                    // Future.delayed(
                    //   1.seconds,
                    //   () {
                    //     audioPlayer.stop();
                    //   },
                    // );
                    // audioPlayer.stop();
                    // SystemNavigator.pop();
                  },
                  child: const Text('Stop')),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString('playingTune', '');
                    exit(0);
                  },
                  child: const Text('Snooze')),
            ],
          ),
        ],
      ),
    ));
  }
}
