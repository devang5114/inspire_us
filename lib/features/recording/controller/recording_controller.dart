import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/recording/repository/recording_repository.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'file';

final recordingController = ChangeNotifierProvider<RecordingController>((ref) {
  return RecordingController(ref);
});

class RecordingController extends ChangeNotifier {
  RecordingController(this.ref);
  Ref ref;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  PermissionStatus audioPermissionStatus = PermissionStatus.denied;
  bool isRecording = false;
  List<String> myRecordings = [];
  String? uploadFilePath;
  String? recordingFilePath;

  bool loading = false;

  init() async {
    final status = await Permission.microphone.request();
    audioPermissionStatus = status;
    if (audioPermissionStatus == PermissionStatus.granted) {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(500.ms);
    }
  }

  initMyRecordings() async {
    loading = true;
    notifyListeners();
    final result = ref.read(recordingRepoProvider).getUserRecording();
  }

  handleRecording(BuildContext context) async {
    if (audioPermissionStatus == PermissionStatus.denied) {
      init();
    } else {
      if (isRecording) {
        stopRecording(context);
        isRecording = false;
      } else {
        startRecording();
        isRecording = true;
      }
      notifyListeners();
    }
  }

  startRecording() async {
    await recorder.startRecorder(toFile: 'audio');
  }

  stopRecording(BuildContext context) async {
    final path = await recorder.stopRecorder();

    if (path == null) return;
    recordingFilePath = path;
    recorder.updateRecorderProgress(duration: 0);

    // ignore: use_build_context_synchronously
    showGeneralDialog(
        context: context,
        transitionDuration: 400.ms,
        pageBuilder: (context, animation, secondaryAnimation) =>
            AlertDialog.adaptive(
              titleTextStyle: TextStyle(fontSize: 20.sp, color: Colors.black),
              title: const Text('Save Recording'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextInput(
                    hintText: 'Name',
                    customBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Colors.grey)),
                    suffixIcon:
                        const Icon(Icons.drive_file_rename_outline_outlined),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MyTextInput(
                    hintText: 'Tag',
                    customBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Colors.grey)),
                    suffixIcon: const Icon(Icons.tag_rounded),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Button(
                    onPressed: () {},
                    disable: true,
                    icon: const Icon(Icons.audio_file_rounded),
                    child: const Text('File'),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('Cancel')),
                Button(
                    onPressed: () {
                      uploadRecordingToServer(recordingFilePath!);
                    },
                    child: const Text('Save')),
              ],
            ),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: animation.drive(Tween(
                  begin: const Offset(0.0, 0.9), end: const Offset(0.0, 0.0))),
              child: FadeTransition(opacity: animation, child: child),
            ));
  }

  saveUploadAudioFile() {
    if (uploadFilePath != null) {
      uploadRecordingToServer(uploadFilePath!);
    } else {
      Fluttertoast.showToast(msg: 'Please Select audio file');
    }
  }

  uploadRecordingToServer(String path) async {
    loading = true;
    notifyListeners();
    await ref.read(recordingRepoProvider).uploadRecordingData(path);
    loading = true;
    notifyListeners();
  }

  disposeController() {
    recorder.stopRecorder();
  }

  pickedFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
        dialogTitle: 'Pick Audio for alarm');
    if (file != null) {
      uploadFilePath = file.files.first.path;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Please Picked file');
    }
  }

  @override
  void dispose() {
    recorder.stopRecorder();
    super.dispose();
  }
}
