import 'package:flutter/material.dart';
import 'package:smart_task/utils/utils.dart';
import 'package:smart_task/widgets/dropdown_menu.dart';

class KDropdownField extends StatelessWidget {
  KDropdownField({
    Key? key,
    this.dropdownFieldOptions,
    required this.controller,
    this.callbackFunction,
  })  : assert(dropdownFieldOptions == null || dropdownFieldOptions.length > 1,
  'Dropdown must have at least two options.'),
        super(key: key);

  final List<String>? dropdownFieldOptions;
  final TextEditingController? controller;
  final VoidCallback? callbackFunction;

  @override
  Widget build(BuildContext context) {
    return DropdownMenus(
      key: key ?? const ValueKey('default_dropdown_key'),
      controller: controller,
      items: dropdownFieldOptions ?? [],
      onChange: callbackFunction,
      hintTextStyle: InkomokoSmartTaskTextStyle.bodyText1(context).copyWith(
        color: InkomokoSmartTaskColors.charcoal,
      ),
      itemTextStyle: InkomokoSmartTaskTextStyle.bodyText1(context).copyWith(
        color: InkomokoSmartTaskColors.charcoal,
      ),
      menuBackgroundColor: InkomokoSmartTaskColors.accent,
      itemBackgroundColor: InkomokoSmartTaskColors.accent,
    );
  }
}