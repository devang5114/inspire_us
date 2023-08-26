import 'package:inspire_us/common/config/theme/theme_export.dart';

import 'audio_tile.dart';

class AudioList extends ConsumerWidget {
  const AudioList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return const AudioTile('assets/audio/sound.mp3');
      },
    );
  }
}
