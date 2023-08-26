import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../widgets/audio_list.dart';

class Audio extends ConsumerWidget {
  const Audio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Audio List',
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: const AudioList());
  }
}
