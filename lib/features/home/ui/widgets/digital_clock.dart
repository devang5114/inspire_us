
import 'package:inspire_us/common/config/theme/theme_export.dart';

import '../../controller/home_controller.dart';

class MyDigitalClock extends ConsumerWidget {
  const MyDigitalClock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(homeController).getCurrentTime;
    return Container(
        color: Colors.white,
        child: Text(time, style: TextStyle(fontSize: 35.sp)));
  }
}
