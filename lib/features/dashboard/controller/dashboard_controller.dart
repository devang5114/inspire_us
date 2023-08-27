import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inspire_us/common/common_repository/notification_repository.dart';
import 'package:inspire_us/common/config/theme/theme_export.dart';

final dashboardController = ChangeNotifierProvider<DashboardController>((ref) {
  return DashboardController(ref);
});

class DashboardController extends ChangeNotifier {
  DashboardController(this.ref) {}
  TabController? tabController;
  Ref ref;
  int index = 2;

  init(TabController val, BuildContext context) async {
    tabController = val;
    tabController!.addListener(() {
      index = tabController!.index;
      notifyListeners();
    });
  }

  setPage(int i) {
    tabController!.animateTo(i);
  }
}
