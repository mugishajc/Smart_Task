import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:smart_task/feature/task_details/views/details_screen.dart';
import 'package:smart_task/utils/utils.dart';

/// Used in [DetailsScreen]
class KTextField extends StatelessWidget {
  const KTextField({
    Key? key,
    required this.controller,
    this.textStyle,
    this.isDateTime = false,
    this.onChanged, // Made nullable
    this.hintText = 'Type something',
  }) : super(key: key);

  final TextEditingController controller;
  final TextStyle? textStyle;
  final bool isDateTime;
  final Function(String value)? onChanged; // Made nullable
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle,
      onTap: () {
        if (isDateTime) {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(1900),
            maxTime: DateTime(2100),
            onConfirm: (date) {
              controller.text = DateFormat('hh:mm aa MMM dd, yyyy').format(date); // Corrected format
              onChanged?.call(controller.text); // Null safe call
            },
            currentTime: DateTime.now(),
            locale: LocaleType.en,
          );
        }
      },
      onChanged: onChanged,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: InkomokoSmartTaskTextStyle.subtitle2.copyWith(
          color: InkomokoSmartTaskColors.charcoal.withOpacity(0.40),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
    );
  }
}

class KTextFormField extends StatefulWidget {
  KTextFormField({
    this.hintText,
    this.hintTextStyle,
    required this.controller,
    this.padding,
    this.multiline = false,
    this.minimumLines = 1,
    this.isPasswordField = false,
    this.isCalenderField = false,
    this.background = InkomokoSmartTaskColors.accent,
  });

  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextEditingController controller;
  final bool multiline;
  final int minimumLines;
  final bool isPasswordField;
  final bool isCalenderField;
  final Color background;
  final double? padding;

  @override
  State<KTextFormField> createState() => _KTextFormFieldState();
}

class _KTextFormFieldState extends State<KTextFormField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.background,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: widget.padding ?? InkomokoSmartTaskSize.width(context, 26),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: TextFormField(
                onTap: () {
                  if (widget.isCalenderField) {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900),
                      maxTime: DateTime(2100),
                      onConfirm: (date) {
                        widget.controller.text =
                            DateFormat('hh:mm aa MMM dd, yyyy').format(date);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.en,
                    );
                  }
                },
                maxLines: widget.multiline ? null : 1,
                minLines: widget.multiline ? widget.minimumLines : 1,
                obscureText: widget.isPasswordField ? !isVisible : false,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle ??
                      InkomokoSmartTaskTextStyle.bodyText1(context).copyWith( // Pass context
                        color: InkomokoSmartTaskColors.charcoal,
                      ),
                  border: InputBorder.none,
                  suffixIcon: widget.isPasswordField
                      ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Image.asset(
                      isVisible
                          ? InkomokoSmartTaskAssets.visibilityOn
                          : InkomokoSmartTaskAssets.visibilityOff,
                    ),
                  )
                      : null,
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: InkomokoSmartTaskSize.height(context, 25),
                    minWidth: InkomokoSmartTaskSize.width(context, 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}