import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/utils/navigation.dart';
import 'package:smart_task/core/base/base_view.dart';
import 'package:smart_task/utils/colors.dart';
import 'package:smart_task/utils/text_style.dart';
import 'package:smart_task/widgets/k_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_task/core/logger.dart';

class ErrorScreen extends BaseView {
  @override
  BaseViewState<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends BaseViewState<ErrorScreen> {
  @override
  PreferredSizeWidget appBar() {
    return KAppBar(
      titleText: "Error",
      onTap: () => Navigator.of(context).canPop() ? const Placeholder().pop(context) : null,
      context: context,
    );
  }

  @override
  bool defaultPadding() => false;

  @override
  bool scrollable() => false;

  @override
  Widget body() {
    return KErrorWidget();
  }
}

class KErrorWidget extends StatelessWidget {
  const KErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "OOPS",
            style: InkomokoSmartTaskTextStyle.headLine2(context).copyWith(
              color: Color(0xFFE5F3F1),
              letterSpacing: 29.5,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Something Went Wrong",
            style: InkomokoSmartTaskTextStyle.headLine3(context).copyWith(
              color: InkomokoSmartTaskColors.charcoal,
            ),
          ),
          SizedBox(height: 30),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text:
              """Sorry, we can’t process your request at the moment. Please try again after sometime. Few things to check: Internet connection, Try restarting the app, Check for update. If nothing works please report a bug""",
              style: InkomokoSmartTaskTextStyle.bodyText1(context).copyWith(
                color: InkomokoSmartTaskColors.charcoal,
              ),
              children: [
                TextSpan(
                    text: " here.",
                    style: InkomokoSmartTaskTextStyle.bodyText1(context).copyWith(
                      color: InkomokoSmartTaskColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final Uri emailLaunchUri = Uri(
                          scheme: 'mailto',
                          path: 'jcmugisha1@gmail.com',
                          queryParameters: <String, String>{
                            'subject': 'Bug Report - Smart Task App'
                          },
                        );
                        try {
                          if (await canLaunchUrl(emailLaunchUri)) {
                            await launchUrl(emailLaunchUri);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No email app found.')),
                            );
                          }
                        } catch (e) {
                          Log.error('Error launching email: $e');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Email launch failed.')),
                          );
                        }
                      })
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}