import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/profile/repository/profile_repository.dart';
import 'package:path/path.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';

import '../../../common/model/user.dart';

final profileController = ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController(ref);
});

class ProfileController extends ChangeNotifier {
  ProfileController(this.ref);

  Ref ref;
  GlobalKey<FormState> editProfileKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  File? pickedImage;
  String? imageName;
  bool loading = false;
  bool editProfileLoading = false;
  bool isErrorOccured = false;
  User? user;

  init(BuildContext context) async {
    loading = true;
    print('hi init');
    ({User? user, String? error}) result =
        await ref.read(profileRepProvider).getUserData();
    print(result.user);
    if (result.user != null) {
      user = result.user;
      loading = false;
      notifyListeners();
    } else {
      isErrorOccured = true;
      Fluttertoast.showToast(
          msg: result.error!,
          gravity: ToastGravity.CENTER,
          backgroundColor: context.colorScheme.onBackground,
          textColor: context.colorScheme.background);
    }
  }

  editProfileInit() {
    nameController.text = user!.name;
    emailAddressController.text = user!.email;
  }

  pickProfileImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      pickedImage = File(file.path!);
      imageName = basename(pickedImage!.path);
      notifyListeners();
    }
  }

  updateProfile(BuildContext context) async {
    if (editProfileKey.currentState!.validate()) {
      editProfileLoading = true;
      notifyListeners();
      if (pickedImage != null) {
        ({bool updateStatus, String? error}) result = await ref
            .read(profileRepProvider)
            .updateUserData(nameController.text, emailAddressController.text,
                pickedImage!.path);
        if (result.updateStatus) {
          init(context);
          context.pop();
        } else {
          Fluttertoast.showToast(
              msg: result.error ?? 'Something went wrong',
              gravity: ToastGravity.CENTER,
              backgroundColor: context.colorScheme.onBackground,
              textColor: context.colorScheme.background);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Please Select Profile Image',
            gravity: ToastGravity.CENTER,
            backgroundColor: context.colorScheme.onBackground,
            textColor: context.colorScheme.background);
      }
      editProfileLoading = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailAddressController.dispose();

    super.dispose();
  }
}
