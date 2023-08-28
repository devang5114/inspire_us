import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../audio/ui/widgets/audio_tile.dart';

class MyRecordings extends ConsumerStatefulWidget {
  const MyRecordings({super.key});

  @override
  ConsumerState<MyRecordings> createState() => _MyRecordingsState();
}

class _MyRecordingsState extends ConsumerState<MyRecordings> {
  @override
  void initState() {
    super.initState();
    ref.read(recordingController.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: context.pop,
            icon: Icon(
              Icons.adaptive.arrow_back_rounded,
              color: context.colorScheme.onBackground,
            )),
        title: Text(
          'My Recordings',
          style: TextStyle(
              fontSize: 20.sp,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (context, index) {
          return const AudioTile(
            title: 'Audios',
            audioPath: 'assets/audio/sound.mp3',
            isRecordingTile: true,
          );
        },
      ),
    );
  }
}
