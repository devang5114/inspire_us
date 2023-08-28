import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/model/alarm_model.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:intl/intl.dart';

import '../../../common/utils/constants/app_const.dart';

final homeController = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController(ref);
});

class HomeController extends ChangeNotifier {
  HomeController(this.ref) {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }
  Ref ref;
  FocusNode focusNode = FocusNode();
  List<AlarmModel> alarmList = [];
  String getCurrentTime = '';
  String get currentTime => getCurrentTime;
  TextEditingController searchController = TextEditingController();
  bool darkMode = false;
  String searchVal = '';

  toggleDarkMode() {
    darkMode = !darkMode;
    ref.read(themeModeProvider.notifier).update((state) {
      if (state == ThemeMode.light) {
        LocalDb.localDb.putValue(isDarkModeActiveKey, true);
        return ThemeMode.dark;
      } else {
        LocalDb.localDb.putValue(isDarkModeActiveKey, false);

        return ThemeMode.light;
      }
    });
    notifyListeners();
  }

  getAlarmList() {
    alarmList = Hive.box<AlarmModel>('alarm').values.toList();
  }

  void updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    if (getCurrentTime != formattedTime) {
      getCurrentTime = formattedTime;
      notifyListeners();
    }
  }

  onSearch(String val) {
    searchVal = val;
    notifyListeners();
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
}
