import 'package:inspire_us/common/config/theme/theme_export.dart';

import 'audio_tile.dart';

class AudioList extends ConsumerWidget {
  const AudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      physics: const BouncingScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return const AudioTile(
          title: 'Audios',
          audioPath: 'assets/audio/sound.mp3',
        );
      },
    );
  }
}
