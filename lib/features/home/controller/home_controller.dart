import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final homeController = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController extends ChangeNotifier {
  HomeController() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTime();
    });
  }
  FocusNode focusNode = FocusNode();
  String getCurrentTime = '';
  String get currentTime => getCurrentTime;
  TextEditingController searchController = TextEditingController();
  bool darkMode = false;

  toggleDarkMode() {
    darkMode = !darkMode;
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
