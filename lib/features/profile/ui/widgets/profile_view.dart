import 'package:inspire_us/common/config/router/app_routes.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/constants/app_assets.dart';
import 'package:inspire_us/common/utils/constants/app_const.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/profile/controller/profile_controller.dart';
import 'package:inspire_us/features/profile/ui/widgets/user_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../common/config/theme/theme_manager.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final profileWatch = ref.watch(profileController);
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 80.r,
            backgroundColor:
                context.colorScheme.primary.withOpacity(isDarkMode ? 0.5 : .2),
            child: CircleAvatar(
                radius: 70.r,
                backgroundImage: CachedNetworkImageProvider(
                  profileWatch.user!.imgUrl,
                )),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onBackground),
                ),
                TextButton(
                    onPressed: () {
                      context.pushNamed(AppRoutes.editProfile);
                    },
                    child: const Text('Edit'))
              ],
            ),
          ),
          const UserDetails()
        ],
      ),
    );
  }
}
