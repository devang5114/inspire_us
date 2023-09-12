import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/global_audio_model.dart';
import 'package:inspire_us/features/alarm/repository/alarm_repository.dart';
import 'package:inspire_us/features/tone/repository/audio_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dashboardController = ChangeNotifierProvider<DashboardController>((ref) {
  return DashboardController(ref);
});

class DashboardController extends ChangeNotifier {
  DashboardController(this.ref);
  TabController? tabController;
  Ref ref;
  int index = 2;

  init(TabController val, BuildContext context) async {
    tabController = val;
    getGlobalRecordings(context);
    AlarmRepository.synchronizeAlarms(ref);
  }

  getGlobalRecordings(BuildContext context) async {
    ({List<GlobalAudioModel>? audioList, String? error}) result =
        await ref.read(toneRepoProvider).getGlobalTones();
    if (result.audioList != null) {
      for (var audio in result.audioList!) {
        downloadAndStorePath(audio);
      }
    } else {
      Fluttertoast.showToast(
        msg: result.error!,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  downloadAndStorePath(GlobalAudioModel audioModel) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Dio dio = Dio();
    final path = await _getSavePath(audioModel.id);

    try {
      if (!(pref.containsKey(audioModel.id))) {
        final result = await dio.download(audioModel.fileUrl, path);
        print('Audio downloaded successfully to $path');
        saveToLocalStorage(audioModel.id, path);
      }
    } on DioException catch (e) {
      print(e.error);
      print(e.message);
    }
  }

  saveToLocalStorage(String id, String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(id, path);
  }

  Future<String> _getSavePath(String id) async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/$id.mp3';
  }

  setPage(int i) {
    tabController!.animateTo(i);
    index = i;
    if (i == 0 || i == 2) {
      AlarmRepository.synchronizeAlarms(ref);
    }
    notifyListeners();
  }
}
