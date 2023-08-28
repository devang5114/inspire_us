import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/local_database_helper.dart';
import 'package:inspire_us/features/dashboard/controller/dashboard_controller.dart';

import '../../../../common/config/router/app_routes.dart';
import '../../../../common/utils/constants/app_assets.dart';
import '../../../../common/utils/constants/app_const.dart';
import '../../controller/home_controller.dart';

class HomeDrawer extends ConsumerStatefulWidget {
  const HomeDrawer(this.scaffoldKey, {super.key});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  ConsumerState<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends ConsumerState<HomeDrawer> {
  bool isDarkModeActive = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    ref.read(homeController.notifier).darkMode = await LocalDb.localDb
        .getValue(isDarkModeActiveKey, defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(10.w, 20.h, 0.w, 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Main menu'.toUpperCase(),
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          ListTile(
            onTap: () {
              widget.scaffoldKey.currentState!.closeDrawer();
            },
            leading: Image.asset(
              AppAssets.homeIcon,
              height: 20.h,
              width: 20.w,
              color: context.colorScheme.primary,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
              color: context.colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              ref.read(dashboardController.notifier).setPage(3);
            },
            leading: Icon(
              Icons.layers,
              color: context.colorScheme.primary,
            ),
            title: Text(
              'Alarm Recording',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
              color: context.colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              context.popAndPushNamed(AppRoutes.myRecording);
            },
            leading: Icon(
              Icons.audio_file,
              color: context.colorScheme.primary,
            ),
            title: Text(
              'My Recording',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
              color: context.colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              ref.read(dashboardController.notifier).setPage(0);
            },
            leading: Icon(
              Icons.layers,
              color: context.colorScheme.primary,
            ),
            title: Text(
              'Alarm Tagging',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
              color: context.colorScheme.primary,
            ),
          ),
          ListTile(
            onTap: () {
              LocalDb.localDb.putValue(isLoggedInKey, false);
              context.pushAndRemoveUntilNamed(AppRoutes.login);
            },
            leading: Icon(
              Icons.logout_outlined,
              color: context.colorScheme.primary,
            ),
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20.h,
              color: context.colorScheme.primary,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: const Divider(
              color: Colors.grey,
            ),
          ),
          Text(
            'settings'.toUpperCase(),
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
          ),
          SwitchListTile(
            value: ref.watch(homeController).darkMode,
            onChanged: (value) {
              ref.read(homeController.notifier).toggleDarkMode();
            },
            title: Row(
              children: [
                Icon(
                  Icons.dark_mode,
                  color: context.colorScheme.primary,
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
          SizedBox(height: 220.h),
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
