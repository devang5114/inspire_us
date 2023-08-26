import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/config/router/app_routes.dart';

class AlarmRing extends StatelessWidget {
  const AlarmRing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('Alarm is Ringing $alarmShowTime'),
          ElevatedButton(
              onPressed: () {
                context.pushAndReplaceNamed(AppRoutes.splash);
              },
              child: const Text('Ok'))
        ],
      ),
    ));
  }
}
