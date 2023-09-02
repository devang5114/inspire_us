import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/audio/repository/audio_repository.dart';

final audioController = ChangeNotifierProvider<AudioController>((ref) {
  return AudioController(ref);
});

class AudioController extends ChangeNotifier {
  AudioController(this.ref);
  Ref ref;
  bool loading = false;
  List<GlobalAudioModel> globalAudioList = [];

  init(BuildContext context) async {
    loading = true;
    ({List<GlobalAudioModel>? audioList, String? error}) result =
        await ref.read(audioRepoProvider).getGlobalTones();
    if (result.audioList != null) {
      globalAudioList = result.audioList!;
    } else {
      Fluttertoast.showToast(
          msg: result.error!,
          gravity: ToastGravity.CENTER,
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
    }
    loading = false;
    notifyListeners();
  }
}
