import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final audioController = ChangeNotifierProvider<AudioController>((ref) {
  return AudioController();
});

class AudioController extends ChangeNotifier {}
