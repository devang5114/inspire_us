import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inspire_us/common/utils/constants/enums.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';
import '../../config/theme/theme_export.dart';

final networkStateProvider = StateProvider<NetworkState>((ref) {
  NetworkState networkState = NetworkState.online;
  Connectivity().onConnectivityChanged.listen((result) {
    if (result == ConnectivityResult.mobile &&
        result == ConnectivityResult.wifi) {
      networkState = NetworkState.online;
    } else if (result == ConnectivityResult.none) {
      networkState = NetworkState.offline;
    }
  });
  return networkState;
});

class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();

  // Default will be online. This controller will help to emit new states when the connection changes.
  final _controller = BehaviorSubject.seeded(NetworkState.online);
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    _checkInternetConnection();
  }

  // The [ConnectionStatusValueNotifier] will subscribe to this
  // stream and every time the connection status changes it
  // will update its value
  Stream<NetworkState> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged
        .listen((_) => _checkInternetConnection());
    return _controller.stream;
  }

  // Code from StackOverflow
  Future<void> _checkInternetConnection() async {
    try {
      // Sometimes, after we connect to a network, this function will
      // be called but the device still does not have an internet connection.
      // This 3 seconds delay will give some time to the device to
      // connect to the internet in order to avoid false-positives
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _controller.sink.add(NetworkState.online);
      } else {
        _controller.sink.add(NetworkState.offline);
      }
    } on SocketException catch (_) {
      _controller.sink.add(NetworkState.offline);
    }
  }

  Future<void> close() async {
    // Cancel subscription and close controller
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}

class ConnectionStatusValueNotifier extends ValueNotifier<NetworkState> {
  // Will keep a subscription to
  // the class [CheckInternetConnection]
  late StreamSubscription _connectionSubscription;

  ConnectionStatusValueNotifier() : super(NetworkState.online) {
    // Everytime there a new connection status is emitted
    // we will update the [value]. This will make the widget
    // to rebuild
    _connectionSubscription = internetChecker
        .internetStatus()
        .listen((newStatus) => value = newStatus);
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}

class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, NetworkState status, child) {
        return Visibility(
          visible: status != NetworkState.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.red,
            child: const Row(
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'No internet connection.',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
