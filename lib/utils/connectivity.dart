import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

enum NetworkStatus { ONLINE, OFFLINE }

// Initial network status provider (checks once on app launch)
final _initNetworkStatusProvider = FutureProvider<NetworkStatus>((ref) async {
  try {
    InternetStatus result = await InternetConnection().internetStatus;
    return result == InternetStatus.connected
        ? NetworkStatus.ONLINE
        : NetworkStatus.OFFLINE;
  } catch (e) {
    print('Error checking connectivity: $e');
    return NetworkStatus.OFFLINE;
  }
});

// Stream provider to listen for internet connection changes
final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  final controller = StreamController<NetworkStatus>();

  ref.onDispose(() {
    controller.close();
  });

  final initialStatus = ref.watch(_initNetworkStatusProvider).value;
  if (initialStatus != null) {
    controller.sink.add(initialStatus);
  } else {
    print("Initial network status is null");
  }

  final subscription = InternetConnection().onStatusChange.listen((status) {
    final networkStatus = status == InternetStatus.connected
        ? NetworkStatus.ONLINE
        : NetworkStatus.OFFLINE;
    controller.add(networkStatus);
  });

  ref.onDispose(() {
    subscription.cancel();
  });

  return controller.stream;
});
