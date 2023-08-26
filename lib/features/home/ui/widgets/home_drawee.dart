

import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../../../common/config/router/app_routes.dart';
import '../../../../common/utils/constants/app_assets.dart';
import '../../controller/home_controller.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
        child: Padding(
      padding: EdgeInsets.fromLTRB(10.w, 20.h, 0.w, 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main menu'.toUpperCase(),
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          ListTile(
            onTap: () {},
            leading: Image.asset(
              AppAssets.homeIcon,
              height: 20.h,
              width: 20.w,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.layers,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Alarm Recording',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.layers,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Alarm Tagging',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
            ),
          ),
          ListTile(
            onTap: () {
              context.pushAndRemoveUntilNamed(AppRoutes.login);
            },
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          Text(
            'settings'.toUpperCase(),
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.color_lens,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Highlights',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
            ),
          ),
          SwitchListTile(
            value: ref.watch(homeController).darkMode,
            onChanged: (value) {
              ref.read(homeController.notifier).toggleDarkMode();
            },
            title: Row(
              children: [
                const Icon(
                  Icons.dark_mode,
                  color: Colors.blueAccent,
                ),
                SizedBox(width: 10.w),
                Text(
                  'Dark Mode',
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'Inspire Us',
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
          SizedBox(height: 8.h),
          Text(
            'App Version 1.0',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          )
        ],
      ),
    ));
  }
}
