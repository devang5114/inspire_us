import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../controller/profile_controller.dart';

class UserDetails extends ConsumerWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final profileWatch = ref.watch(profileController);

    return Column(
      children: [
        SizedBox(height: 10.h),
        ListTile(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: profileWatch.user!.name));
            Fluttertoast.showToast(
                msg: 'Copy to clip board',
                backgroundColor: context.colorScheme.onBackground,
                textColor: context.colorScheme.background);
          },
          leading: CircleAvatar(
            radius: 25.r,
            backgroundColor: context.colorScheme.primary.withOpacity(.3),
            child: Icon(
              Icons.person,
              color: context.colorScheme.onBackground,
            ),
          ),
          title: Text(
            'Name',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              profileWatch.user!.name,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ),
        ListTile(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: profileWatch.user!.email));
            Fluttertoast.showToast(
                msg: 'Copy to clip board',
                backgroundColor: context.colorScheme.onBackground,
                textColor: context.colorScheme.background);
          },
          leading: CircleAvatar(
            radius: 25.r,
            backgroundColor: context.colorScheme.primary.withOpacity(.3),
            child: Icon(
              Icons.mail,
              color: context.colorScheme.onBackground,
            ),
          ),
          title: Text(
            'Email Address',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              profileWatch.user!.email,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }
}
