import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) async* {
  final connectivity = Connectivity();

  final initialResult = await connectivity.checkConnectivity();

  yield initialResult.contains(ConnectivityResult.mobile) ||
      initialResult.contains(ConnectivityResult.wifi);

  await for (final result in connectivity.onConnectivityChanged) {
    yield result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
  }
});
