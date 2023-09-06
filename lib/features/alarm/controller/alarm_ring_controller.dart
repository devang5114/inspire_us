import 'dart:async';

import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:intl/intl.dart';

final alarmRingController = ChangeNotifierProvider<AlarmRingController>((ref) {
  return AlarmRingController();
});

class AlarmRingController extends ChangeNotifier {
  AlarmRingController() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }

  String getCurrentTime = '';

  void updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    if (getCurrentTime != formattedTime) {
      getCurrentTime = formattedTime;
      notifyListeners();
    }
  }
}
