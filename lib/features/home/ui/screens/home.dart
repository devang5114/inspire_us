import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_drawee.dart';
import '../widgets/home_view.dart';
import '../widgets/theme_color_picker_bottom_sheet.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.grid_view_rounded,
                color: Colors.blueAccent,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return const ThemeColorPickerBottomSheet();
                    },
                  );
                },
                icon: Icon(
                  Icons.color_lens,
                  color: Colors.blueAccent,
                ))
          ],
        ),
        drawer: const HomeDrawer(),
        body: const HomeView());
  }
}
