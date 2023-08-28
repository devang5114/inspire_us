import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';

import '../../../../common/config/theme/theme_export.dart';
import '../../../../common/utils/widgets/button.dart';
import '../../../../common/utils/widgets/text_input.dart';

class UploadWidget extends ConsumerWidget {
  const UploadWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingWatch = ref.watch(recordingController);
    // bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Upload Audio File',
              style: TextStyle(fontSize: 20.sp, color: Colors.black)),
          SizedBox(height: 20.h),
          MyTextInput(
            hintText: 'Name',
            customBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.grey)),
            suffixIcon: const Icon(Icons.drive_file_rename_outline_outlined),
          ),
          SizedBox(height: 15.h),
          MyTextInput(
            hintText: 'Tag',
            customBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: const BorderSide(color: Colors.grey)),
            suffixIcon: const Icon(Icons.tag_rounded),
          ),
          SizedBox(height: 20.h),
          Button(
            backgroundColor: context.colorScheme.primary.withOpacity(.5),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            onPressed: () {
              ref.read(recordingController.notifier).pickedFile();
            },
            borderRadius: BorderRadius.circular(10.r),
            icon: const Icon(Icons.audio_file_rounded),
            child: Text(
              recordingWatch.uploadFilePath ?? 'Choose File',
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
              maxLines: 1,
            ),
          ),
          SizedBox(height: 15.h),
          Button(
              backgroundColor: context.colorScheme.primary,
              onPressed:
                  ref.read(recordingController.notifier).saveUploadAudioFile,
              child: Text(
                'Save',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
    );
  }
}
