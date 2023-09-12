import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/loading.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/features/auth/controller/register_controller.dart';
import 'package:inspire_us/features/recording/controller/recording_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../common/config/theme/theme_manager.dart';
import '../../../tone/ui/widgets/audio_tile.dart';

class MyRecordings extends ConsumerStatefulWidget {
  const MyRecordings({super.key});

  @override
  ConsumerState<MyRecordings> createState() => _MyRecordingsState();
}

class _MyRecordingsState extends ConsumerState<MyRecordings> {
  @override
  void initState() {
    super.initState();
    ref.read(recordingController.notifier).initMyRecordings(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final recordingWatch = ref.watch(recordingController);
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
      body: recordingWatch.myRecordingLoading
          ? const Loading()
          : recordingWatch.myRecordings.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No tones available ',
                        style: TextStyle(
                            fontSize: 15.sp,
                            color: context.colorScheme.onBackground),
                      ),
                      SizedBox(height: 20.h),
                      Button(
                          onPressed: context.pop,
                          backgroundColor: context.colorScheme.primary,
                          child: Text(
                            'Add New Tone',
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.white),
                          )),
                    ],
                  ),
                )
              : LiquidPullToRefresh(
                  backgroundColor: Colors.white,
                  springAnimationDurationInMilliseconds: 500,
                  onRefresh: () => ref
                      .read(recordingController.notifier)
                      .initMyRecordings(context),
                  child: ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: recordingWatch.myRecordings.length,
                    itemBuilder: (context, index) {
                      final audioModel = recordingWatch.myRecordings
                          .toList()
                          .reversed
                          .toList()[index];
                      return AudioTile(audioModel: audioModel);
                    },
                  ),
                ),
    );
  }
}
