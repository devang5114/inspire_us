import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recordingController = ChangeNotifierProvider<RecordingController>((ref) {
  return RecordingController();
});

class RecordingController extends ChangeNotifier{}