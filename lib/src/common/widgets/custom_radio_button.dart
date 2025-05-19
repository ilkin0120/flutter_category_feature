import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';
import 'custom_gap.dart';

class CustomRadioButton extends StatelessWidget {
  final String title;
  final String? description;
  final Function(dynamic) onTap;
  final dynamic value;

  /// is Radio button enabled. If Radio butonn is not enabled then we cannot click on it
  final bool isEnabled;

  /// is Radio button active.
  final bool isActive;
  final Widget? child;
  final TextStyle titleTextStyle;
  final EdgeInsets buttonPadding;

  const CustomRadioButton(
      {super.key,
      required this.title,
      required this.onTap,
      required this.value,
      required this.isActive,
      required this.titleTextStyle,
      this.isEnabled = true,
      this.buttonPadding = const EdgeInsets.symmetric(vertical: 8),
      this.child,
      this.description});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (isEnabled) {
          onTap(value);
        }
      },
      child: Container(
        padding: buttonPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _circle(context),
            const HorizontalGap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: titleTextStyle.copyWith(
                            color: isEnabled
                                ? context.color.primaryTextColor
                                : context.color.disableColor),
                      ),
                      if (description != null)
                        Column(
                          children: [
                            const VerticalGap(4),
                            Text(
                              description!,
                              maxLines: 3,
                              style: context.text.bodySmall.copyWith(
                                  height: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: isEnabled
                                      ? context.color.secondaryTextColor
                                      : context.color.disableColor),
                            ),
                          ],
                        )
                    ],
                  ),
                  AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeIn,
                      duration: UIConstants.fastAnimationDuration,
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -.3),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: // Show child if radio button is active and has a child
                          child != null && isActive ? child : null),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _circle(BuildContext context) {
    return AnimatedContainer(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              width: 2,
              color: isActive
                  ? context.color.primaryColor
                  : context.color.secondaryColor)),
      padding: const EdgeInsets.all(4),
      duration: UIConstants.fastAnimationDuration,
      child: AnimatedContainer(
        duration: UIConstants.fastAnimationDuration,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive ? context.color.primaryColor : null,
        ),
      ),
    );
  }
}
