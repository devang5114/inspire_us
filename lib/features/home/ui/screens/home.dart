// import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/utils/extentions/context_extention.dart';
import 'package:just_audio/just_audio.dart';

import '../widgets/home_drawee.dart';
import '../widgets/home_view.dart';
import '../widgets/theme_color_picker_bottom_sheet.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () => context.focusScope.unfocus(),
      child: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: context.colorScheme.primary,
                )),
          ),
          drawer: HomeDrawer(scaffoldKey),
          body: const HomeView()),
    );
  }
}
