import 'package:inspire_us/common/utils/extentions/context_extention.dart';

import '../../config/theme/theme_export.dart';

class TextInput extends StatelessWidget {
  TextInput(
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
      this.focusNode});

  final String? label;
  final String? hintText;
  final bool autoValidateMode;
  final bool obscureText;
  final bool borderInputNone;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  String? Function(String?)? onChange;
  final void Function()? onTap;
  final OutlineInputBorder? customBorder;
  final FocusNode? focusNode;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autovalidateMode: autoValidateMode
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      style: TextStyle(fontSize: 16.sp),
      cursorColor: context.primaryColor,
      textAlignVertical: TextAlignVertical.bottom,
      onTap: onTap,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: padding,
        labelStyle: TextStyle(fontSize: 16.sp),
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
        border: borderInputNone
            ? InputBorder.none
            : customBorder ??
                const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),

        focusedBorder: borderInputNone
            ? InputBorder.none
            : customBorder ??
                const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
        enabledBorder: borderInputNone
            ? InputBorder.none
            : customBorder ??
                const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),

        // border:
      ),
      validator: validator,
      onChanged: onChange,
    );
  }
}
