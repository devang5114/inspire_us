import 'package:carousel_slider/carousel_slider.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:inspire_us/features/audio/ui/screens/audio.dart';
import 'package:inspire_us/features/home/ui/widgets/digital_clock.dart';

import '../../../../common/utils/widgets/button.dart';
import '../../../audio/ui/widgets/audio_tile.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SearchAnchor(
              builder: (context, controller) {
                return SearchBar(
                  onTap: () => controller.openView(),
                  leading: const Icon(Icons.search),
                  padding: MaterialStateProperty.resolveWith(
                      (states) => EdgeInsets.symmetric(horizontal: 20.w)),
                  hintText: 'Search Alarm for Tagging',
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.transparent),
                  elevation: MaterialStateProperty.resolveWith((states) => 0),
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          side: BorderSide(color: Colors.grey.shade300))),
                  hintStyle: MaterialStateProperty.resolveWith(
                      (states) => const TextStyle(color: Colors.grey)),
                );
              },
              suggestionsBuilder: (context, controller) {
                return [];
              },
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.blueAccent, width: 3)),
              child: const FittedBox(child: MyDigitalClock())),
          SizedBox(height: 20.h),
          SizedBox(
            height: 130.h,
            width: context.screenWidth,
            child: CarouselSlider.builder(
                itemCount: 3,
                itemBuilder: (context, index, realIndex) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      color: [
                        Colors.deepOrangeAccent,
                        Colors.deepPurpleAccent,
                        Colors.greenAccent
                      ][index],
                      width: context.screenWidth * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Happy Weekend',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            '60% off',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    initialPage: 0, viewportFraction: 0.8, autoPlay: true)),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recomended Sounds',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'View more',
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AudioTile('assets/audio/sound.mp3'),
                SizedBox(height: 20.h),
                Button(
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  borderRadius: BorderRadius.circular(20.r),
                  backgroundColor: Colors.transparent,
                  borderSide: BorderSide(color: Colors.blueAccent),
                  onPressed: () {
                    context.push(const Audio());
                  },
                  child: Text(
                    'View More'.toUpperCase(),
                    style: TextStyle(fontSize: 15.sp, color: Colors.blueAccent),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
