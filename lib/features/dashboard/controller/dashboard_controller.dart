import 'package:inspire_us/common/config/theme/theme_export.dart';

final dashboardController = ChangeNotifierProvider<DashboardController>((ref) {
  return DashboardController(ref);
});

class DashboardController extends ChangeNotifier {
  DashboardController(this.ref);
  TabController? tabController;
  Ref ref;
  int index = 0;

  init(TabController val) {
    tabController = val;
    notifyListeners();
    tabController!.addListener(() {
      index = tabController!.index;
      notifyListeners();
    });
  }

  setPage(int i) {
    index = i;
    notifyListeners();
  }
}
