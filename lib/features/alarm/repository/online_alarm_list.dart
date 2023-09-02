import 'package:inspire_us/common/config/theme/theme_export.dart';

class OnlinAlarmList extends ConsumerStatefulWidget {
  const OnlinAlarmList({super.key});

  @override
  ConsumerState<OnlinAlarmList> createState() => _OnlinAlarmListState();
}

class _OnlinAlarmListState extends ConsumerState<OnlinAlarmList> {
  @override
  void initState() {
    super.initState();
    // ref.read()
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {},
    );
  }
}
