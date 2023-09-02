import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/user.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/common/utils/helper/validator.dart';
import 'package:inspire_us/common/utils/widgets/button.dart';
import 'package:inspire_us/common/utils/widgets/text_input.dart';
import 'package:inspire_us/features/profile/controller/profile_controller.dart';

import '../../../../common/config/theme/theme_manager.dart';
import '../../../../common/utils/helper/loading.dart';

class ProfileEdit extends ConsumerStatefulWidget {
  const ProfileEdit({super.key});

  @override
  ConsumerState<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends ConsumerState<ProfileEdit> {
  @override
  void initState() {
    super.initState();
    ref.read(profileController.notifier).editProfileInit();
  }

  @override
  Widget build(BuildContext context) {
    final profileWatch = ref.watch(profileController);
    final profileRead = ref.read(profileController);
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: isDarkMode ? Colors.black : Colors.white,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: context.pop,
              icon: Icon(
                Icons.adaptive.arrow_back_rounded,
                color: context.colorScheme.onBackground,
              )),
          title: Text(
            'Edit Profile',
            style: TextStyle(
                fontSize: 20.sp,
                color: isDarkMode ? Colors.white : Colors.blueAccent,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: profileWatch.editProfileLoading
            ? Loading()
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: profileRead.editProfileKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color:
                                isDarkMode ? Colors.white : Colors.blueAccent,
                          )),
                      SizedBox(height: 10.h),
                      MyTextInput(
                        validator: nameValidator,
                        controller: profileRead.nameController,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 18.h),
                        customBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                      SizedBox(height: 20.h),
                      Text('Email Address',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color:
                                isDarkMode ? Colors.white : Colors.blueAccent,
                          )),
                      SizedBox(height: 10.h),
                      MyTextInput(
                        validator: emailValidator,
                        controller: profileRead.emailAddressController,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 18.h),
                        customBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                      SizedBox(height: 20.h),
                      Button(
                          backgroundColor: context.colorScheme.surface,
                          icon: const Icon(Icons.image),
                          onPressed: ref
                              .read(profileController.notifier)
                              .pickProfileImage,
                          child: Text(
                            profileWatch.imageName != null
                                ? profileWatch.imageName!
                                : 'Choose Image for your Profile',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: context.colorScheme.onSurface),
                          )),
                      SizedBox(height: 20.h),
                      Button(
                          backgroundColor: context.colorScheme.primary,
                          child: Text(
                            'Update Profile',
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.white),
                          ),
                          onPressed: () => profileRead.updateProfile(context))
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
