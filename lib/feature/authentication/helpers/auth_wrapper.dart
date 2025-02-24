import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/feature/home/views/home_screen.dart';
import 'package:smart_task/feature/startup/views/welcome_screen.dart';
import 'package:smart_task/feature/error/view/error_screen.dart';
import 'package:smart_task/core/logger.dart'; // Import your logger

import '../../../data/repository/authentication/authentication_repository.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final asyncUser = ref.watch(authStateChangesProvider);

    return asyncUser.when(
      data: (user) => user != null ? HomeScreen() : WelcomeScreen(),
      loading: () => WelcomeScreen(), // Add const
      error: (e, stackTrace) {
        Log.error("AuthenticationWrapper error: $e");
        Log.error(stackTrace.toString());
        return ErrorScreen();
      },
    );
  }
}