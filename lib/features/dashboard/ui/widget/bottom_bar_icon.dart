import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

class BottomBarIcon extends ConsumerWidget {
  const BottomBarIcon({
    super.key,
    required this.iconData,
    required this.title,
    required this.onPress,
    required this.isSelected,
  });
  final IconData iconData;
  final String title;
  final void Function() onPress;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isCalender = 'Audio File' == title;
    return Container(
      margin: EdgeInsets.only(right: isCalender ? 50.w : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashColor: Colors.transparent,
            onPressed: onPress,
            icon: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          if (isSelected)
            Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ).animate().fade()
        ],
      ),
    );
  }
}
