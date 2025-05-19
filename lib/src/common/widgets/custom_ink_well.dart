import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

class CustomInkWell extends StatefulWidget {
  final BorderRadius? borderRadius;
  final GestureTapCallback onTap;

  final bool disableEffects;
  final GestureTapCallback? onDoubleTap;
  final GestureTapCallback? onLongTap;
  final Widget child;

  const CustomInkWell({
    super.key,
    required this.onTap,
    required this.child,
    this.disableEffects = false,
    this.borderRadius,
    this.onDoubleTap,
    this.onLongTap,
  });

  @override
  State<CustomInkWell> createState() => _CustomInkWellState();
}

class _CustomInkWellState extends State<CustomInkWell> {
  int lastClickMilliseconds = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: widget.borderRadius,
      hoverColor: widget.disableEffects
          ? Colors.transparent
          : context.color.secondaryColor,
      focusColor: widget.disableEffects
          ? Colors.transparent
          : context.color.secondaryColor,
      highlightColor: widget.disableEffects
          ? Colors.transparent
          : context.color.secondaryColor,
      splashColor: widget.disableEffects
          ? Colors.transparent
          : context.color.secondaryColor,
      onLongPress: widget.onLongTap,
      onTap: () {
        int currMills = DateTime.now().millisecondsSinceEpoch;
        if ((currMills - lastClickMilliseconds) < 300 &&
            widget.onDoubleTap != null) {
          widget.onDoubleTap!();
        } else {
          lastClickMilliseconds = currMills;
          widget.onTap();
        }
      },
      child: widget.child,
    );
  }
}
