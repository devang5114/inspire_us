import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../widgets/recording view.dart';

class Recording extends ConsumerWidget {
  const Recording({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'New Alarm Tone',
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: const DefaultTabController(length: 2, child: RecordingView()));
  }
}
