import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { ONLINE, OFFLINE }

final _initNetworkStatusProvider = FutureProvider<NetworkStatus>((ref) async {
  try {
    final result = await Connectivity().checkConnectivity();
    return _mapConnectivityResultToNetworkStatus(result.first);
  } catch (e) {
    // Handle error (e.g., log, show error message)
    print('Error checking connectivity: $e');
    return NetworkStatus.OFFLINE; // Default to OFFLINE on error
  }
});

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final controller = StreamController<NetworkStatus>();

  ref.onDispose(() {
    controller.close();
  });

  final initialStatus = ref.watch(_initNetworkStatusProvider).value;
  if (initialStatus != null) {
    controller.sink.add(initialStatus);
  } else {
    // Handle initial null state (e.g., add a loading state)
    print("Initial network status is null");
  }

  final subscription = Connectivity().onConnectivityChanged.listen((result) {
    controller.add(_mapConnectivityResultToNetworkStatus(result.first));
  });

  ref.onDispose(() {
    subscription.cancel();
  });

  return controller.stream;
});

NetworkStatus _mapConnectivityResultToNetworkStatus(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.wifi:
    case ConnectivityResult.mobile:
      return NetworkStatus.ONLINE;
    default:
      return NetworkStatus.OFFLINE;
  }
}