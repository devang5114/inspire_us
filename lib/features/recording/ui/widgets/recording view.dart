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
        // const TabBarView(children: [RecordingWidget(), UploadWidget()])
      ],
    );
  }
}
