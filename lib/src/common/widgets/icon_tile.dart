import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class IconTile extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool isSelected;
  final Color? borderColor;
  final double size;
  final double borderWidth;

  const IconTile(
      {super.key,
      required this.color,
      required this.isSelected,
      required this.icon,
      this.borderColor,
      this.borderWidth = 1,
      this.size = 56});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: UIConstants.fastAnimationDuration,
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          border: Border.all(color: borderColor ?? color, width: borderWidth),
          borderRadius: UIConstants.defaultBorderRadius),
      child: AnimatedSwitcher(
        duration: UIConstants.fastAnimationDuration,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Icon(
          icon,
          key: ValueKey<bool>(isSelected),
          color: isSelected ? Colors.white : color,
          size: 24,
        ),
      ),
    );
  }
}
