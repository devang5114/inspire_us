import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/features/alarm/ui/widget/alarms_list.dart';
import 'package:inspire_us/features/home/controller/home_controller.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeWatch = ref.watch(homeController);
    final time = ref.watch(homeController).getCurrentTime;
    return Column(
      children: [
        SearchAnchor(
          builder: (context, controller) {
            return InkWell(
              onTap: () => controller.openView(),
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 15.w, 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    SizedBox(width: 5.w),
                    Text(
                      'Search Alarm for Tagging',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
          suggestionsBuilder: (context, controller) {
            return [];
          },
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: Colors.blueAccent, width: 3)),
            child: Text(time, style: TextStyle(fontSize: 35.sp))),
        SizedBox(height: 20.h),
        const AlarmList()
      ],
    );
  }
}
