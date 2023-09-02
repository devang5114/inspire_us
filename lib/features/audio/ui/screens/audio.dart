import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/helper/loading.dart';
import 'package:inspire_us/common/utils/helper/network_state_helper.dart';
import 'package:inspire_us/features/audio/controller/audio_controller.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../widgets/audio_list.dart';

class Audio extends ConsumerStatefulWidget {
  const Audio({super.key});

  @override
  ConsumerState<Audio> createState() => _AudioState();
}

class _AudioState extends ConsumerState<Audio> {
  @override
  void initState() {
    super.initState();
    ref.read(audioController.notifier).init(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final audioWatch = ref.watch(audioController);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Audio List',
            style: TextStyle(
                fontSize: 20.sp,
                color: isDarkMode ? Colors.white : Colors.blueAccent,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: audioWatch.loading
            ? const Loading()
            : const Column(
                children: [
                  WarningWidgetValueNotifier(),
                  Expanded(child: AudioList()),
                ],
              ));
  }
}
