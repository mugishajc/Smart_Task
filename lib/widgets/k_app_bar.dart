import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:smart_task/utils/utils.dart';

class KAppBar extends AppBar {
  KAppBar({
    Key? key,
    required this.titleText,
    required this.onTap,
    this.trailing,
    required this.context,
  }) : super(
    key: key,
    leadingWidth: 0,
    titleSpacing: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ExpandTapWidget(
            onTap: onTap,
            tapPadding: const EdgeInsets.all(20.0),
            child: Image.asset(
              InkomokoSmartTaskAssets.backButton,
              height: InkomokoSmartTaskSize.height(context, 32),
              width: InkomokoSmartTaskSize.width(context, 32),
            ),
          ),
          Text(titleText, style: InkomokoSmartTaskTextStyle.headLine4(context)),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );

  final String titleText;
  final VoidCallback onTap;
  final Widget? trailing;
  final BuildContext context;
}