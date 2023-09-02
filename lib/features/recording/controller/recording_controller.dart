import 'package:file_picker/file_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/recording/repository/recording_repository.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/model/audio_model.dart';
import '../../../common/utils/constants/enums.dart';
// import 'file';

final recordingController = ChangeNotifierProvider<RecordingController>((ref) {
  return RecordingController(ref);
});

class RecordingController extends ChangeNotifier {
  RecordingController(this.ref);
  Ref ref;
  FlutterSoundRecorder recorder = FlutterSoundRecorder();
  GlobalKey<FormState> recordingFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> uploadFormKey = GlobalKey<FormState>();
  PermissionStatus audioPermissionStatus = PermissionStatus.denied;
  bool isRecording = false;
  int index = 0;
  List<AudioModel> myRecordings = [];
  String? uploadFilePath;
  String? uploadFileName;
  String? uploadTitle;
  String? uploadTags;
  String? recordingFilePath;
  String? recordingTitle;
  String? recordingTags;
  bool loading = false;
  bool recordLoading = false;
  bool myRecordingLoading = false;

  setIndex(int i) {
    index = i;
    uploadFileName = null;
    notifyListeners();
  }

  init() async {
    final status = await Permission.microphone.request();
    audioPermissionStatus = status;
    if (audioPermissionStatus == PermissionStatus.granted) {
      await recorder.openRecorder();
      recorder.setSubscriptionDuration(500.ms);
    }
  }

  initMyRecordings(BuildContext context) async {
    myRecordingLoading = true;
    // notifyListeners();
    ({List<AudioModel>? audioList, String? error}) result =
        await ref.read(recordingRepoProvider).getUserRecording();
    if (result.audioList != null) {
      myRecordings = result.audioList!;
    } else {
      Fluttertoast.showToast(
        msg: result.error!,
        backgroundColor: context.colorScheme.onBackground,
        textColor: context.colorScheme.background,
        gravity: ToastGravity.CENTER,
      );
    }
    myRecordingLoading = false;
    notifyListeners();
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
              titleTextStyle: TextStyle(
                  fontSize: 20.sp, color: context.colorScheme.onBackground),
              title: const Text('Save Recording'),
              content: Form(
                key: recordingFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyTextInput(
                      hintText: 'Title',
                      validator: (val) {
                        if (val == null && val!.isEmpty) {
                          return 'Please Enter audio title';
                        } else if (val.length < 2) {
                          return 'Title Must be 2 character long';
                        }
                        return null;
                      },
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      onChange: (val) {
                        recordingTitle = val;
                        notifyListeners();
                      },
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
                      validator: (val) {
                        if (val == null && val!.isEmpty) {
                          return 'Please Enter audio tag';
                        } else if (val.length < 2) {
                          return 'tag Must be 2 character long';
                        }
                        return null;
                      },
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      onChange: (val) {
                        recordingTags = val;
                        notifyListeners();
                      },
                      customBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: const Icon(Icons.tag_rounded),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Visibility(
                      visible: recordLoading,
                      replacement: Button(
                        onPressed: () {},
                        disable: true,
                        icon: const Icon(Icons.audio_file_rounded),
                        child: Text(recordingTitle != null
                            ? '$recordingTitle.mp3'
                            : 'File.mp3'),
                      ),
                      child: CircularProgressIndicator(
                        color: context.colorScheme.primary,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: context.colorScheme.onBackground),
                    )),
                Button(
                    backgroundColor: context.colorScheme.primary,
                    onPressed: () {
                      if (recordingFormKey.currentState!.validate()) {
                        uploadRecordingToServer(
                            context,
                            recordingFilePath!,
                            recordingTitle!,
                            recordingTags!,
                            AudioSendType.recording);
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    )),
              ],
            ),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
              position: animation.drive(Tween(
                  begin: const Offset(0.0, 0.9), end: const Offset(0.0, 0.0))),
              child: FadeTransition(opacity: animation, child: child),
            ));
  }

  saveUploadAudioFile(BuildContext context) {
    if (uploadFilePath != null) {
      uploadFileName = null;
      uploadRecordingToServer(context, uploadFilePath!, uploadTitle!,
          uploadTags!, AudioSendType.upload);
    } else {
      Fluttertoast.showToast(
          msg: 'Please Select audio file',
          gravity: ToastGravity.CENTER,
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
    }
  }

  uploadRecordingToServer(BuildContext context, String path, String title,
      String tags, AudioSendType audioSendType) async {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    loading = true;
    recordLoading = true;
    notifyListeners();
    ({bool uploadStatus, String? error}) result = await ref
        .read(recordingRepoProvider)
        .uploadRecordingData(path, title, tags);
    if (result.uploadStatus) {
      Fluttertoast.showToast(
          msg: 'Tone Uploaded Successfully..',
          gravity: ToastGravity.CENTER,
          backgroundColor: isDarkMode ? Colors.white : Colors.black,
          textColor: isDarkMode ? Colors.black : Colors.white);
      if (audioSendType == AudioSendType.recording) {
        context.pop();
        recordingTitle = '';
        recordingTags = '';
        notifyListeners();
      } else {
        uploadTitle = '';
        uploadTags = '';
        notifyListeners();
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Failed to upload audio try again..',
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
    }
    loading = false;
    recordLoading = false;
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
      uploadFileName = basename(uploadFilePath!);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Please Picked file');
    }
  }

  deleteTone(String toneId, BuildContext context) async {
    ({String? error, bool isDeleted}) result =
        await ref.read(recordingRepoProvider).deleteTone(toneId);
    if (result.isDeleted) {
      myRecordings.removeWhere((audio) => audio.id.toString() == toneId);
      Fluttertoast.showToast(
          msg: 'Tone delete',
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
      notifyListeners();
    } else {
      print(result.error);
      Fluttertoast.showToast(
          msg: 'Failed To delete this tone',
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
    }
  }

  @override
  void dispose() {
    recorder.stopRecorder();
    super.dispose();
  }
}
