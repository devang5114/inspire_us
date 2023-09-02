import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // Navigation
  void push(Widget widget) =>
      Navigator.push(this, MaterialPageRoute(builder: (context) => widget));

  void pop() => Navigator.pop(this);

  void pushNamed(String route, {Object? arguments}) =>
      Navigator.pushNamed(this, route, arguments: arguments);

  void pushAndRemoveUntilNamed(String route) =>
      Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);

  void pushAndReplaceNamed(String route) =>
      Navigator.pushReplacementNamed(this, route);

  void popAndPushNamed(String route, {dynamic arguments}) =>
      Navigator.popAndPushNamed(this, route, arguments: arguments);

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(behavior: SnackBarBehavior.floating, content: Text(msg)));
  }

  FocusScopeNode get focusScope => FocusScope.of(this);

  // ui helper
  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get screenWidth => MediaQuery.sizeOf(this).width;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get primaryColor => Theme.of(this).primaryColor;
}
