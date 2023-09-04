import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight,
      width: context.screenWidth,
      color: context.colorScheme.background,
      child: Center(
        child: Container(
            height: 70.h,
            width: 70.w,
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(10.r)),
            child: Center(
              child: CircularProgressIndicator(
                color: context.colorScheme.primary,
              ),
            )),
      ),
    );
  }
}
