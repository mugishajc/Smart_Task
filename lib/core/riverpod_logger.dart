import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/core/logger.dart';
import 'dart:convert';

class RiverpodLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    try {
      final log = {
        'provider': provider.name ?? provider.runtimeType.toString(),
        'providerType': provider.runtimeType.toString(),
        'providerHashcode': provider.hashCode,
        'previousValue': previousValue?.toString(),
        'newValue': newValue?.toString(),
        'newValueType': newValue.runtimeType.toString(),
      };
      Log.info(jsonEncode(log));
    } catch (e, stackTrace) {
      Log.error('Error logging Riverpod update: $e');
      Log.error(stackTrace.toString());
    }
  }
}