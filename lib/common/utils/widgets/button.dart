import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      this.padding,
      required this.child,
      required this.onPressed,
      this.icon,
      this.backgroundColor,
      this.borderRadius,
      this.height,
      this.width,
      this.elevation,
      this.borderSide,
      this.disable = false});
  final Widget child;
  final void Function() onPressed;
  final EdgeInsets? padding;
  final Widget? icon;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;
  final bool disable;
  final BorderSide? borderSide;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: padding,
              shape: borderRadius != null
                  ? RoundedRectangleBorder(borderRadius: borderRadius!)
                  : null),
          onPressed: disable ? null : onPressed,
          icon: icon!,
          label: child);
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: padding,
            elevation: elevation,
            side: borderSide,
            backgroundColor: backgroundColor,
            shape: borderRadius != null
                ? RoundedRectangleBorder(borderRadius: borderRadius!)
                : null),
        onPressed: disable ? null : onPressed,
        child: child);
  }
}
