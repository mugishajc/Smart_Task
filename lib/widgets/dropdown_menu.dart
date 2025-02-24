import 'package:flutter/material.dart';

class DropdownMenus extends StatefulWidget {
  const DropdownMenus({
    Key? key,
    this.controller,
    this.items,
    this.onChange,
    this.trailing = const Icon(Icons.arrow_drop_down),
    this.showTrailing = true,
    this.hintTextStyle = const TextStyle(color: Colors.black),
    this.itemTextStyle = const TextStyle(color: Colors.black),
    this.menuBackgroundColor = Colors.white,
    this.itemBackgroundColor = Colors.white,
    this.padding = const EdgeInsets.fromLTRB(12, 12, 12, 12),
  }) : super(key: key);

  final TextEditingController? controller;
  final List<String>? items;
  final Widget trailing;
  final bool showTrailing;
  final TextStyle hintTextStyle;
  final TextStyle itemTextStyle;
  final Color menuBackgroundColor;
  final Color itemBackgroundColor;
  final EdgeInsets padding;
  final Function? onChange;

  @override
  _DropdownMenusState createState() => _DropdownMenusState();
}

class _DropdownMenusState extends State<DropdownMenus> {
  final GlobalKey<State<DropdownMenus>> _key = GlobalKey();
  OverlayEntry? _overlayEntry;
  Size? _menuSize;
  Offset? _menuPosition;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null && (widget.controller!.text.isEmpty)) {
      widget.controller!.text = 'Select an option';
    }
  }

  void findWidget() {
    RenderBox? renderBox = _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      _menuSize = renderBox.size;
      _menuPosition = renderBox.localToGlobal(Offset.zero);
    }
  }

  void openDropDownMenu() {
    findWidget();
    if (_menuSize != null && _menuPosition != null) {
      _overlayEntry = _overlayEntryBuilder();
      if (_overlayEntry != null) {
        Overlay.of(context).insert(_overlayEntry!);
        _isActive = true;
      }
    }
  }

  void closeDropDownMenu() {
    if (_isActive && _overlayEntry != null) {
      _overlayEntry!.remove();
      _isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        closeDropDownMenu();
        return true;
      },
      child: Container(
        key: _key,
        color: widget.menuBackgroundColor,
        padding: widget.padding,
        child: InkWell(
          onTap: () {
            if (_isActive) {
              closeDropDownMenu();
            } else {
              openDropDownMenu();
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.controller?.text ?? 'Select an option',
                style: widget.hintTextStyle,
              ),
              Visibility(
                visible: widget.showTrailing,
                child: widget.trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropDownMenuBuilder(List<String> item) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: item.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              if (widget.controller != null) {
                widget.controller!.text = item[index];
              }
            });
            if (widget.onChange != null) widget.onChange!();
            closeDropDownMenu();
          },
          child: Container(
            width: _menuSize?.width ?? 0,
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(color: widget.itemBackgroundColor),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    item[index],
                    style: widget.itemTextStyle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OverlayEntry? _overlayEntryBuilder() {
    if (_menuPosition == null || _menuSize == null) {
      return null;
    }
    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () => closeDropDownMenu(),
              ),
            ),
            Positioned(
              top: _menuPosition!.dy + _menuSize!.height + 5,
              left: _menuPosition!.dx,
              width: _menuSize!.width,
              child: Material(
                child: _dropDownMenuBuilder(widget.items ?? []),
              ),
            ),
          ],
        );
      },
    );
  }
}