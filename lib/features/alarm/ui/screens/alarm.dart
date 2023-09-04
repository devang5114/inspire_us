import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/features/alarm/controller/alarm_controller.dart';
import 'package:inspire_us/features/alarm/ui/widget/alarm_list.dart';
import 'package:inspire_us/features/dashboard/ui/widget/add_fab.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../common/config/theme/theme_manager.dart';

class Alarm extends ConsumerStatefulWidget {
  const Alarm({super.key});

  @override
  ConsumerState<Alarm> createState() => _AlarmState();
}

class _AlarmState extends ConsumerState<Alarm> {
  @override
  void initState() {
    super.initState();
    // ref.read(alarmController.notifier).init(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    bool isOnline = ref.watch(networkStateProvider) == NetworkState.online;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Alarm Taging',
          style: TextStyle(
              fontSize: 20.sp,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: const Column(
        children: [
          WarningWidgetValueNotifier(),
          Expanded(child: AlarmList()),
        ],
      ),
      floatingActionButton: const AddFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  play() async {
    final audioPlayer = AudioPlayer();
    await audioPlayer
        .setFilePath('path/storage/emulated/0/Download/1693646741-23.mp3');
    audioPlayer.play();
  }
}
