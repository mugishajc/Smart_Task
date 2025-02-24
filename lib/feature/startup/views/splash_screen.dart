import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_task/constant/shared_preference_key.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/core/logger.dart';
import 'package:smart_task/feature/authentication/controllers/authentication_controller.dart';
import 'package:smart_task/feature/authentication/helpers/auth_wrapper.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/utils/utils.dart';

class SplashScreen extends BaseView {
  @override
  BaseViewState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseViewState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      if (getBoolAsync(NEW_INSTALL, defaultValue: true)) {
        await setValue(NEW_INSTALL, false);
        try {
          await ref.read(authenticationProvider.notifier).signOut();
        } catch (e, stackTrace) {
          Log.error("Error signing out: $e");
          Log.error(stackTrace.toString());
        }
      }
      const AuthenticationWrapper().pushAndRemoveUntil(context);
    });
  }

  @override
  bool scrollable() => false;

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Smart App",
            style: InkomokoSmartTaskTextStyle.headLine3(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Not your every day todo app",
            style: InkomokoSmartTaskTextStyle.subtitle1,
          ),
          Image.asset(
            InkomokoSmartTaskAssets.google,
            width: MediaQuery.of(context).size.width * .30,
          ),
        ],
      ),
    );
  }
}