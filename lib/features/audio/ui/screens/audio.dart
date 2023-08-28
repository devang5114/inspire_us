import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../widgets/audio_list.dart';

class Audio extends ConsumerWidget {
  const Audio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
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
        body: const AudioList());
  }
}
