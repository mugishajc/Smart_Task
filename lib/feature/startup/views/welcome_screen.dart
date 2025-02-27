import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/feature/authentication/views/login_screen.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../authentication/controllers/authentication_controller.dart';
import '../../authentication/views/sign_up_screen.dart';

class WelcomeScreen extends BaseView {
  WelcomeScreen({super.key});

  @override
  BaseViewState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends BaseViewState<WelcomeScreen> {
  @override
  Widget body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context, 288)),
        SizedBox(
          width: InkomokoSmartTaskSize.width(context, 439),
          child: Text(
            "Start Using Inkomoko Smart Task App Today!",
            textAlign: TextAlign.center,
            style: InkomokoSmartTaskTextStyle.headLine3(context),
          ),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 61)),
        KFilledButton(
          buttonText: 'Create Account',
          onPressed: () => SignupScreen().push(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 106)),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: InkomokoSmartTaskTextStyle.bodyText1(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 87)),
        KOutlinedButton.iconText(
          buttonText: 'Sign up with Google',
          assetIcon: InkomokoSmartTaskAssets.google,
          onPressed: () =>
              ref.read(authenticationProvider.notifier).signInWithGoogle(),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 308)),
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: InkomokoSmartTaskTextStyle.bodyText3(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 6)),
        KTextButton(
            buttonText: "Login",
            onPressed: () {
              LoginScreen().push(context);
            })
      ],
    );
  }
}