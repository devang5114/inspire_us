import 'package:inspire_us/common/config/theme/theme_export.dart';
import 'package:inspire_us/common/model/user.dart';

final userDataProvider =
    StateNotifierProvider<UserDataNotifier, User>((ref) => UserDataNotifier());

class UserDataNotifier extends StateNotifier<User> {
  UserDataNotifier() : super(User(id: 0, name: '', email: '', path: ''));

  init(User user) {
    state = user;
  }
}
