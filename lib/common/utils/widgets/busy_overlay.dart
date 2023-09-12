import 'dart:ui';

import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

class BusyOverlay extends StatelessWidget {
  const BusyOverlay(
      {super.key,
      required this.child,
      required this.show,
      this.hideBg = false});
  final Widget child;
  final bool show;
  final bool hideBg;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      child: IgnorePointer(
        ignoring: show,
        child: Stack(
          children: [
            if (!hideBg) child,
            if (show)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 1, sigmaX: 1),
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.black26,
                  child: Center(
                    child: Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.colorScheme.primary,
                          ),
                        )),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
