import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/tone/repository/audio_repository.dart';

import '../../../common/config/theme/theme_manager.dart';

final toneController = ChangeNotifierProvider<ToneController>((ref) {
  return ToneController(ref);
});

class ToneController extends ChangeNotifier {
  ToneController(this.ref);
  Ref ref;
  bool loading = false;
  bool tonesLoading =false;
  List<GlobalAudioModel> tonesList = [];
  List<String> allTagsList = [];


  // init(BuildContext context) async {
  //   loading = true;
  //   ({List<GlobalAudioModel>? audioList, String? error}) result =
  //       await ref.read(audioRepoProvider).getGlobalTones();
  //   if (result.audioList != null) {
  //     globalAudioList = result.audioList!;
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: result.error!,
  //         gravity: ToastGravity.CENTER,
  //         backgroundColor: context.colorScheme.onBackground,
  //         textColor: context.colorScheme.background);
  //   }
  //   loading = false;
  //   notifyListeners();
  // }

  getAllToneTags(BuildContext context) async {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    loading = true;
    // notifyListeners();
    ({List<String>? tagList, String? error}) result =
        await ref.read(toneRepoProvider).getAllTags();
    if (result.tagList != null) {
      allTagsList = result.tagList!;
      loading = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: result.error!,
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        textColor: isDarkMode ? Colors.black : Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
  getTonesByTag(String tag) async {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    tonesLoading = true;
    ({List<GlobalAudioModel>? audioList, String? error}) result =
        await ref.read(toneRepoProvider).getTonesByTag(tag);
    if (result.audioList != null) {
      print(result.audioList);
      tonesList = result.audioList!;
      print(tonesList);
      tonesLoading = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(
        msg: result.error!,
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        textColor: isDarkMode ? Colors.black : Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
