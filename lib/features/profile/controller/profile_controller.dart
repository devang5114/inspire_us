import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:path/path.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';

final profileController = ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController();
});

class ProfileController extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? pickedImage;
  String? imageName;

  init() {}

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

  updateProfile(BuildContext context) {
    context.pop();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
