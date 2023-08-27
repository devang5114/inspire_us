import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:intl/intl.dart';

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
  String getCurrentTime = '';
  String get currentTime => getCurrentTime;
  TextEditingController searchController = TextEditingController();
  bool darkMode = false;

  toggleDarkMode() {
    darkMode = !darkMode;
    ref.read(themeModeProvider.notifier).update((state) {
      if (state == ThemeMode.light) {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    });
    notifyListeners();
  }

  void updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    if (getCurrentTime != formattedTime) {
      getCurrentTime = formattedTime;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
}
