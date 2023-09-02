import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';

import '../../../../common/config/theme/theme_export.dart';
import '../../../../common/utils/helper/loading.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../../../common/utils/widgets/text_input.dart';

class UploadWidget extends ConsumerWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingWatch = ref.watch(recordingController);
    // bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return recordingWatch.loading
        ? const Loading()
        : ValueListenableBuilder(
            valueListenable: ConnectionStatusValueNotifier(),
            builder: (context, state, child) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: recordingWatch.uploadFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    Text('Upload Audio File',
                        style: TextStyle(fontSize: 20.sp, color: Colors.black)),
                    SizedBox(height: 20.h),
                    MyTextInput(
                      hintText: 'title',
                      validator: (val) {
                        if (val == null && val!.isEmpty) {
                          return 'Please Enter audio title';
                        } else if (val.length < 2) {
                          return 'Title Must be 2 character long';
                        }
                        return null;
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      onChange: (val) {
                        ref.read(recordingController.notifier).uploadTitle =
                            val;
                      },
                      customBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon:
                          const Icon(Icons.drive_file_rename_outline_outlined),
                    ),
                    SizedBox(height: 15.h),
                    MyTextInput(
                      hintText: 'Tag',
                      autoValidateMode: AutovalidateMode.onUserInteraction,
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
                        ref.read(recordingController.notifier).uploadTags = val;
                      },
                      customBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: Colors.grey)),
                      suffixIcon: const Icon(Icons.tag_rounded),
                    ),
                    SizedBox(height: 20.h),
                    Button(
                      backgroundColor:
                          context.colorScheme.primary.withOpacity(.5),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      onPressed: () {
                        if (state == NetworkState.online) {
                          ref.read(recordingController.notifier).pickedFile();
                        } else {
                          Fluttertoast.showToast(
                            msg: 'You are offline',
                            backgroundColor: context.colorScheme.onBackground,
                            gravity: ToastGravity.CENTER,
                            textColor: context.colorScheme.background,
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      icon: const Icon(Icons.audio_file_rounded),
                      child: Text(
                        recordingWatch.uploadFileName ?? 'Choose File',
                        style: TextStyle(fontSize: 13.sp, color: Colors.white),
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Button(
                        backgroundColor: context.colorScheme.primary,
                        onPressed: () {
                          if (state == NetworkState.online) {
                            if (recordingWatch.uploadFormKey.currentState!
                                .validate()) {
                              ref
                                  .read(recordingController.notifier)
                                  .saveUploadAudioFile(context);
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: 'You are offline',
                              backgroundColor: context.colorScheme.onBackground,
                              gravity: ToastGravity.CENTER,
                              textColor: context.colorScheme.background,
                            );
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
