import 'package:inspire_us/common/config/theme/theme_manager.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../config/theme/theme_export.dart';

class MyTextInput extends ConsumerWidget {
  MyTextInput(
      {super.key,
      this.label,
      this.obscureText = false,
      this.autoValidateMode = false,
      this.validator,
      this.suffixIcon,
      this.keyboardType,
      this.onChange,
      this.hintText,
      this.padding,
      this.borderInputNone = false,
      this.prefixIcon,
      this.customBorder,
      this.onTap,
      this.focusNode,
      this.controller});

  final String? label;
  final String? hintText;
  final bool autoValidateMode;
  final bool obscureText;
  final bool borderInputNone;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final TextEditingController? controller;
  String? Function(String?)? onChange;
  final void Function()? onTap;
  final OutlineInputBorder? customBorder;
  final FocusNode? focusNode;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: autoValidateMode
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      style:
          TextStyle(fontSize: 16.sp, color: context.colorScheme.onBackground),
      cursorColor: isDarkMode ? Colors.white : Colors.blueAccent,
      textAlignVertical: TextAlignVertical.bottom,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: padding,
        labelStyle: TextStyle(
            fontSize: 16.sp, color: isDarkMode ? Colors.blueGrey : Colors.grey),
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
        border: borderInputNone
            ? InputBorder.none
            : customBorder ??
                UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colorScheme.primary)),

        focusedBorder: borderInputNone
            ? InputBorder.none
            : customBorder ??
                UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colorScheme.primary)),
        enabledBorder: borderInputNone
            ? InputBorder.none
            : customBorder ??
                UnderlineInputBorder(
                    borderSide: BorderSide(color: context.colorScheme.primary)),

        // border:
      ),
      validator: validator,
      onChanged: onChange,
    );
  }
}
