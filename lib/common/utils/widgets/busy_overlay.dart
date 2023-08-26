import 'dart:ui';

import 'package:inspire_us/common/config/theme/theme_export.dart';

class BusyOverlay extends StatelessWidget {
  const BusyOverlay({super.key, required this.child, required this.show});
  final Widget child;
  final bool show;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      child: IgnorePointer(
        ignoring: show,
        child: Stack(
          children: [
            child,
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
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
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
