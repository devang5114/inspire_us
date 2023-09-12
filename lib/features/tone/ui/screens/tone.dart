import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/tone/ui/widgets/tone_category_list.dart';
import 'package:inspire_us/features/tone/controller/tone_controller.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../common/utils/helper/loading.dart';
import '../../../../common/utils/helper/network_state_helper.dart';

class Tone extends ConsumerStatefulWidget {
  const Tone({super.key});

  @override
  ConsumerState<Tone> createState() => _TuneCategoryState();
}

class _TuneCategoryState extends ConsumerState<Tone> {
  @override
  void initState() {
    super.initState();
    fetchTags();
  }

  Future<void> fetchTags() async {
    ref.read(toneController).getAllToneTags(context);
  }

  @override
  Widget build(BuildContext context) {
    final toneWatch = ref.watch(toneController);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Global Tones',
            style: TextStyle(color: context.colorScheme.onBackground),
          ),
        ),
        body: toneWatch.loading
            ? const Loading()
            : LiquidPullToRefresh(
                backgroundColor: Colors.white,
                springAnimationDurationInMilliseconds: 500,
                onRefresh: fetchTags,
                child: const Column(
                  children: [
                    WarningWidgetValueNotifier(),
                    Expanded(child: ToneCategoryList()),
                  ],
                ),
              ));
  }
}
