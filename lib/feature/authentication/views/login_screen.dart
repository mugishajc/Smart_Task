import 'package:flutter/material.dart';
import 'package:smart_task/core/base/base_state.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/feature/authentication/views/sign_up_screen.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:smart_task/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../home/views/home_screen.dart';
import '../controllers/authentication_controller.dart';

class LoginScreen extends BaseView {
  @override
  BaseViewState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseViewState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void buildMethod() {
    ref.listen(authenticationProvider, (_, state) {
      if (state is SuccessState) {
        HomeScreen().pushAndRemoveUntil(context);
      } else if (state is ErrorState) {
        snackBar(context,
            title: state.message, backgroundColor: InkomokoSmartTaskColors.charcoal);
      }
    });
  }

  @override
  Widget body() {
    final authState = ref.watch(authenticationProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context,332)),
        Container(
          width: InkomokoSmartTaskSize.width(context,315),
          child: Text(
            "Welcome Back",
            textAlign: TextAlign.center,
            style: InkomokoSmartTaskTextStyle.headLine3(context),
          ),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,63)),
        KTextFormField(
          hintText: 'Your email address',
          controller: emailController,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,37)),
        KTextFormField(
          hintText: 'Password',
          controller: passwordController,
          isPasswordField: true,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Forgot your password?',
              style: InkomokoSmartTaskTextStyle.bodyText2(context)
                  .copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,61)),
        KFilledButton(
          buttonText: authState is LoadingState ? 'Please wait' : 'Login',
          buttonColor: authState is LoadingState
              ? InkomokoSmartTaskColors.spaceCadet
              : InkomokoSmartTaskColors.primary,
          onPressed: () {
            if (!(authState is LoadingState)) {
              if (emailController.text.trim().isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                hideKeyboard(context);
                ref.read(authenticationProvider.notifier).signIn(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              } else {
                if (emailController.text.trim().isEmpty) {
                  snackBar(context,
                      title: "Please enter email",
                      backgroundColor: InkomokoSmartTaskColors.charcoal);
                } else if (passwordController.text.isEmpty) {
                  snackBar(context,
                      title: "Please enter password",
                      backgroundColor: InkomokoSmartTaskColors.charcoal);
                }
              }
            }
          },
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,66)),
        Text(
          "Or",
          textAlign: TextAlign.center,
          style: InkomokoSmartTaskTextStyle.bodyText1(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,72)),
        KOutlinedButton.iconText(
          onPressed: () =>
              ref.read(authenticationProvider.notifier).signInWithGoogle(),
          buttonText: 'Login with Google',
          assetIcon: InkomokoSmartTaskAssets.google,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,131)),
        Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: InkomokoSmartTaskTextStyle.bodyText3(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context,6)),
        KTextButton(
            buttonText: "Create account",
            onPressed: () {
              SignupScreen().pushReplacement(context);
            })
      ],
    );
  }
}
