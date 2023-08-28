import 'package:inspire_us/common/config/router/app_routes.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../controller/recording_controller.dart';
import '../widgets/recording_view.dart';

class Recording extends ConsumerStatefulWidget {
  const Recording({super.key});

  @override
  ConsumerState<Recording> createState() => _RecordingState();
}

class _RecordingState extends ConsumerState<Recording> {
  @override
  void initState() {
    super.initState();
    ref.read(recordingController).init();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Alarm Tone',
            style: TextStyle(
                fontSize: 20.sp,
                color: isDarkMode ? Colors.white : Colors.blueAccent,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () => context.pushNamed(AppRoutes.myRecording),
                icon: Icon(
                  Icons.audio_file,
                  color: context.colorScheme.primary,
                ))
          ],
        ),
        body: const DefaultTabController(length: 2, child: RecordingView()));
  }
}
