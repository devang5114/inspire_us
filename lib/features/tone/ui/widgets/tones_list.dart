import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/loading.dart';
import 'package:inspire_us/features/tone/controller/tone_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../common/utils/helper/network_state_helper.dart';
import 'audio_tile.dart';

class TonesList extends ConsumerStatefulWidget {
  const TonesList({super.key, required this.tag});

  final String tag;

  @override
  ConsumerState<TonesList> createState() => _TonesListState();
}

class _TonesListState extends ConsumerState<TonesList> {
  @override
  void initState() {
    super.initState();
    getTagTone();
  }

  Future<void> getTagTone() async {
    ref.read(toneController.notifier).getTonesByTag(widget.tag);
  }

  @override
  Widget build(BuildContext context) {
    final tonesWatch = ref.watch(toneController);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.tag,
            style: TextStyle(color: context.colorScheme.onBackground),
          ),
          leading: IconButton(
              onPressed: context.pop,
              icon: Icon(
                Icons.adaptive.arrow_back_rounded,
                color: context.colorScheme.onBackground,
              )),
        ),
        body: tonesWatch.tonesLoading
            ? const Loading()
            : LiquidPullToRefresh(
                backgroundColor: Colors.white,
                springAnimationDurationInMilliseconds: 500,
                onRefresh: getTagTone,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WarningWidgetValueNotifier(),
                    if (tonesWatch.tonesList.isEmpty)
                      emptyListWidget(context, ref)
                    else
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          physics: const BouncingScrollPhysics(),
                          itemCount: tonesWatch.tonesList.length,
                          itemBuilder: (context, index) {
                            final globalAudioModel =
                                tonesWatch.tonesList.reversed.toList()[index];
                            return AudioTile(
                              globalAudioModel: globalAudioModel,
                            );
                          },
                        ),
                      )
                  ],
                ),
              ));
  }

  Widget emptyListWidget(BuildContext context, WidgetRef ref) => Center(
          child: Text(
        'No tones available ',
        style:
            TextStyle(fontSize: 15.sp, color: context.colorScheme.onBackground),
      ));
}
