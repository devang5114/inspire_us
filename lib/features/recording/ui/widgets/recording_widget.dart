import 'package:inspire_us/common/utils/constants/app_assets.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';

import '../../../../common/config/theme/theme_export.dart';

class RecordingWidget extends StatelessWidget {
  const RecordingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.h),
        Text(
          'Record Alarm Tone',
          style: TextStyle(fontSize: 25.sp),
        ),
        SizedBox(height: 30.h),
        Container(
          height: 200.h,
          width: 200.w,
          padding: EdgeInsets.all(30.r),
          decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(.1), shape: BoxShape.circle),
          child: Image.asset(
            AppAssets.voiceIcon,
            height: 150.h,
            width: 150.w,
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          '10:55',
          style: TextStyle(fontSize: 20.sp),
        ),
        SizedBox(height: 30.h),
        Button(
            icon: const Icon(Icons.play_arrow_sharp),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Text(
              'Start Recording',
              style: TextStyle(fontSize: 15.sp),
            ),
            onPressed: () {})
      ],
    );
  }
}
