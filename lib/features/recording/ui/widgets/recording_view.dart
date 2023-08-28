import 'package:inspire_us/features/recording/ui/widgets/recording_widget.dart';
import 'package:inspire_us/features/recording/ui/widgets/upload_widget.dart';

import '../../../../common/config/theme/theme_export.dart';

class RecordingView extends ConsumerWidget {
  const RecordingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TabBar(tabs: [
          Tab(
            child: Text(
              'RECORD',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Tab(
            child: Text(
              'UPLOAD',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ]),
        const Expanded(
            child: TabBarView(children: [RecordingWidget(), UploadWidget()]))
      ],
    );
  }
}
