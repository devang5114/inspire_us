import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';

class ThemeColorPickerBottomSheet extends ConsumerWidget {
  const ThemeColorPickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Color> colors = [
      Colors.blue,
      Colors.grey,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.deepOrangeAccent,
      Colors.indigoAccent,
      Colors.lightGreenAccent,
      Colors.blue,
      Colors.grey,
      Colors.purpleAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.amberAccent,
      Colors.deepOrangeAccent,
      Colors.indigoAccent,
      Colors.lightGreenAccent,
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      width: context.screenWidth,
      height: context.screenHeight * 0.5,
      child: Wrap(
        spacing: 20.w,
        runSpacing: 20.h,
        children: List.generate(
            colors.length,
            (index) => InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: colors[index]),
                  ),
                )),
      ),
    );
  }
}
