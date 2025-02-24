import 'package:flutter/material.dart';
import 'package:smart_task/utils/utils.dart';

class KExpansionTile extends StatelessWidget {
  const KExpansionTile({
    Key? key,
    this.title,
    this.trailing,
    this.children,
  }) : super(key: key);

  final Widget? title;
  final Widget? trailing;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        dividerColor: InkomokoSmartTaskColors.transparent,
        dividerTheme: const DividerThemeData(
          space: 0,
          endIndent: 0,
          indent: 0,
          thickness: 0,
        ),
      ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        tilePadding: EdgeInsets.zero,
        iconColor: InkomokoSmartTaskColors.primary,
        title: title ?? const SizedBox.shrink(), // Default widget if null
        trailing: trailing ?? const SizedBox.shrink(), // Default widget if null
        children: children ?? const <Widget>[],
      ),
    );
  }
}