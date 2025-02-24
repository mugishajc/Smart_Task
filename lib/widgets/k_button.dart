import 'package:flutter/material.dart';
import 'package:smart_task/utils/utils.dart';

// _KButton
class _KButton extends StatelessWidget {
  _KButton({
    required this.child,
    required this.onPressed,
    this.border,
    this.backgroundColor = InkomokoSmartTaskColors.primary,
    this.height,
    this.width = double.infinity,
  });

  final Widget child;
  final Color backgroundColor;
  final double? height;
  final double width;
  final VoidCallback onPressed;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
        ),
        child: child,
      ),
    );
  }
}

// KFilledButton
class KFilledButton extends _KButton {
  KFilledButton({
    required String buttonText,
    required VoidCallback onPressed,
    Color buttonColor = InkomokoSmartTaskColors.primary,
  }) : super(
    child: Builder(
      builder: (context) {
        return Center(
          child: Text(
            buttonText,
            style: InkomokoSmartTaskTextStyle.buttonText(context).copyWith(
              color: InkomokoSmartTaskColors.white,
            ),
          ),
        );
      },
    ),
    onPressed: onPressed,
    backgroundColor: buttonColor,
    height: 84, //fixed height
    border: Border.all(
      color: ListifyTheme.darkMode()
          ? InkomokoSmartTaskColors.white
          : InkomokoSmartTaskColors.charcoal,
    ),
  );

  KFilledButton.iconText({
    required IconData icon,
    required String buttonText,
    required VoidCallback onPressed,
    Color buttonColor = InkomokoSmartTaskColors.primary,
  }) : super(
    child: Builder(
      builder: (context) {
        return Row(
          children: [
            SizedBox(width: InkomokoSmartTaskSize.width(context, 31)),
            Icon(icon, color: InkomokoSmartTaskColors.white),
            SizedBox(width: InkomokoSmartTaskSize.width(context, 24)),
            Text(
              buttonText,
              style: InkomokoSmartTaskTextStyle.bodyText2(context).copyWith(
                color: InkomokoSmartTaskColors.white,
              ),
            )
          ],
        );
      },
    ),
    onPressed: onPressed,
    backgroundColor: buttonColor,
    height: 84, //fixed height
  );
}

// KOutlinedButton
class KOutlinedButton extends _KButton {
  KOutlinedButton({
    required String buttonText,
    required VoidCallback onPressed,
    TextStyle? textStyle,
    Color? borderColor,
  }) : super(
    child: Builder(
      builder: (context) {
        return Center(
          child: Text(
            buttonText,
            style: textStyle ??
                InkomokoSmartTaskTextStyle.buttonText(context,
                    fontWeight: FontWeight.w500),
          ),
        );
      },
    ),
    onPressed: onPressed,
    backgroundColor: InkomokoSmartTaskColors.transparent,
    height: 84, //fixed height
    border: Border.all(
      color: borderColor ??
          (ListifyTheme.darkMode()
              ? InkomokoSmartTaskColors.white
              : InkomokoSmartTaskColors.charcoal),
    ),
  );

  KOutlinedButton.iconText({
    required String buttonText,
    VoidCallback? onPressed,
    String? assetIcon,
  }) : super(
    child: Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (assetIcon != null)
              Container(
                height: InkomokoSmartTaskSize.height(context, 34),
                width: InkomokoSmartTaskSize.width(context, 34),
                child: Image.asset(assetIcon),
              ),
            if (assetIcon != null) SizedBox(width: InkomokoSmartTaskSize.width(context, 22)),
            Text(
              buttonText,
              style: InkomokoSmartTaskTextStyle.buttonText(context,
                  fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
    ),
    onPressed: onPressed ?? () {},
    backgroundColor: InkomokoSmartTaskColors.transparent,
    height: 84, //fixed height
    border: Border.all(
      color: ListifyTheme.darkMode()
          ? InkomokoSmartTaskColors.white
          : InkomokoSmartTaskColors.charcoal,
    ),
  );
}

// KTextButton
class KTextButton extends _KButton {
  KTextButton({
    required String buttonText,
    TextStyle? buttonTextStyle,
    required VoidCallback onPressed,
    TextAlign textAlign = TextAlign.center,
  }) : super(
    child: Builder(
      builder: (context) {
        return Text(
          buttonText,
          textAlign: textAlign,
          style: buttonTextStyle ?? InkomokoSmartTaskTextStyle.bodyText2(context),
        );
      },
    ),
    onPressed: onPressed,
    height: null,
    backgroundColor: InkomokoSmartTaskColors.transparent,
  );

  KTextButton.iconText({
    required String buttonText,
    TextStyle? buttonTextStyle,
    String? assetIcon,
    required VoidCallback onPressed,
  }) : super(
    child: Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: [
              if (assetIcon != null)
                Image.asset(
                  assetIcon,
                  width: InkomokoSmartTaskSize.width(context, 20),
                  height: InkomokoSmartTaskSize.height(context, 20),
                ),
              if (assetIcon != null) SizedBox(width: InkomokoSmartTaskSize.width(context, 15)),
              Text(
                buttonText,
                style: buttonTextStyle ?? InkomokoSmartTaskTextStyle.bodyText3(context),
              ),
            ],
          ),
        );
      },
    ),
    onPressed: onPressed,
    backgroundColor: InkomokoSmartTaskColors.transparent,
    height: null,
  );
}