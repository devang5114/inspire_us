import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
// import ' '

final recordingController = ChangeNotifierProvider<RecordingController>((ref) {
  return RecordingController();
});

class RecordingController extends ChangeNotifier {
  FlutterSoundRecorder flutterSoundRecorder = FlutterSoundRecorder();

  init() {
    // final status = await Permission
  }

  @override
  void dispose() {
    flutterSoundRecorder.closeRecorder();
    super.dispose();
  }
}
