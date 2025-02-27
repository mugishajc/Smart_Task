// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:smart_task/core/base/base_state.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/feature/authentication/views/login_screen.dart';
import 'package:smart_task/feature/home/views/home_screen.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/k_button.dart';
import 'package:smart_task/widgets/k_textfield.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/authentication_controller.dart';

class SignupScreen extends BaseView {
  const SignupScreen({super.key});

  @override
  BaseViewState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends BaseViewState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  void buildMethod() {
    ref.listen(
      authenticationProvider,
          (_, state) {
        if (state is SuccessState) {
          HomeScreen().pushAndRemoveUntil(context);
        } else if (state is ErrorState) {
          snackBar(context,
              title: state.message, backgroundColor: InkomokoSmartTaskColors.charcoal);
        }
      },
    );
    super.buildMethod();
  }

  @override
  Widget body() {
    final authState = ref.watch(authenticationProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: InkomokoSmartTaskSize.height(context, 288)),
        SizedBox(
          width: InkomokoSmartTaskSize.width(context, 439),
          child: Text(
            "Not your everyday Todo app!",
            textAlign: TextAlign.center,
            style: InkomokoSmartTaskTextStyle.headLine3(context),
          ),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 44)),
        KTextFormField(
          hintText: 'Email Address',
          controller: emailController,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 37)),
        KTextFormField(
          hintText: 'Password',
          controller: passwordController,
          isPasswordField: true,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 37)),
        KTextFormField(
          hintText: 'Confirm Password',
          controller: confirmPasswordController,
          isPasswordField: true,
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 106)),
        KFilledButton(
          buttonText:
          authState is LoadingState ? 'Please wait' : 'Create Account',
          buttonColor: authState is LoadingState
              ? InkomokoSmartTaskColors.spaceCadet
              : InkomokoSmartTaskColors.primary,
          onPressed: () {
            if (authState is! LoadingState) {
              hideKeyboard(context);
              if (emailController.text.trim().isNotEmpty && emailController.text.trim().isValidEmail()) {
                if (passwordController.text.length >= 6) {
                  if (passwordController.text == confirmPasswordController.text) {
                    ref.read(authenticationProvider.notifier).signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  } else {
                    snackBar(context,
                        title: "Password doesn't match",
                        backgroundColor: InkomokoSmartTaskColors.charcoal);
                  }
                } else {
                  snackBar(context,
                      title: "Password should be at least 6 characters",
                      backgroundColor: InkomokoSmartTaskColors.charcoal);
                }
              } else {
                snackBar(context, title: "Please enter a valid email", backgroundColor: InkomokoSmartTaskColors.charcoal);
              }
            }
          },
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 110)),
        Text(
          "Already have an account?",
          textAlign: TextAlign.center,
          style: InkomokoSmartTaskTextStyle.bodyText3(context),
        ),
        SizedBox(height: InkomokoSmartTaskSize.height(context, 6)),
        KTextButton(
            buttonText: "Login",
            onPressed: () {
              LoginScreen().pushReplacement(context);
            })
      ],
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}