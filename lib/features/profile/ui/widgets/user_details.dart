import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/config/theme/theme_manager.dart';

class UserDetails extends ConsumerWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Column(
      children: [
        ListTile(
          onLongPress: () {
            Clipboard.setData(const ClipboardData(text: '32323972397'));
            Fluttertoast.showToast(msg: 'Copy to clip board');
          },
          leading: CircleAvatar(
            radius: 25.r,
            backgroundColor: context.colorScheme.primary.withOpacity(.3),
            child: Icon(
              Icons.call,
              color: context.colorScheme.onBackground,
            ),
          ),
          title: Text(
            'Mobile Number',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              '32323972397',
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        ListTile(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: '32323972397'));
            Fluttertoast.showToast(msg: 'Copy to clip board');
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
              'user@gmail.com',
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        ListTile(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: '32323972397'));
            Fluttertoast.showToast(msg: 'Copy to clip board');
          },
          leading: CircleAvatar(
            radius: 25.r,
            backgroundColor: context.colorScheme.primary.withOpacity(.3),
            child: Icon(
              Icons.location_pin,
              color: context.colorScheme.onBackground,
            ),
          ),
          title: Text(
            'Address',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              'New york ',
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }
}
