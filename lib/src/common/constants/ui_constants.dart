import 'package:flutter/cupertino.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

class UIConstants {
  static const double defaultHorizontalPadding = 17.0;
  static const defaultAnimationDuration = Duration(milliseconds: 300);
  static const fastAnimationDuration = Duration(milliseconds: 200);
  static const xFastAnimationDuration = Duration(milliseconds: 150);
  static const textFieldPadding =
      EdgeInsets.symmetric(horizontal: 12, vertical: 14);
  static final BorderRadius defaultBorderRadius = BorderRadius.circular(8);

  static Border getDefaultBorder(BuildContext context, bool? isActive) {
    return Border.all(
      width: 1.5,
      color: isActive != null
          ? !isActive
              ? context.color.secondaryColor
              : context.color.primaryColor
          : context.color.secondaryColor,
    );
  }

  static Border getDisableBorder(BuildContext context) {
    return Border.all(
      width: 1.5,
      color: context.color.disableColor,
    );
  }
  static TextStyle getAlertDialogContentTextStyle(BuildContext context) {
    return context.text.bodyMedium.copyWith(
        fontWeight: FontWeight.w500,
        color: context.color.secondaryTextColor);
  }
  static TextStyle getDefaultHintStyle(BuildContext context) {
    return context.text.bodyMedium.copyWith(
      color: context.color.secondaryTextColor,
      fontWeight: FontWeight.w500,
    );
  }
}
