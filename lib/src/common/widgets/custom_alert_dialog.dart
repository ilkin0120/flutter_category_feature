import 'package:flutter_category_feature/src/common/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter_category_feature/src/common/widgets/custom_button.dart';
import 'package:flutter_category_feature/src/common/widgets/custom_gap.dart';

/// A customizable and flexible alert dialog widget.
class CustomAlertDialog extends StatelessWidget {
  /// Title text displayed at the top of the dialog.
  final String? title;

  /// Optional simple text content below the title.
  final String? content;

  /// Optional custom widget to replace the text content.
  final Widget? customContent;

  /// Text for the confirmation button.
  final String confirmText;

  /// Text for the cancel button.
  final String cancelText;

  /// Callback triggered when the confirmation button is pressed.
  final VoidCallback? onConfirm;

  /// Callback triggered when the cancel button is pressed.
  final VoidCallback? onCancel;

  /// If true, the confirmation button will use an error color (e.g., for delete actions).
  final bool isConfirmDestructive;

  /// If true, shows the cancel button.
  final bool showCancelButton;

  /// If false, disables the confirmation button.
  final bool isConfirmEnabled;

  const CustomAlertDialog({
    super.key,
    this.title,
    this.content,
    this.customContent,
    this.confirmText = 'Подтвердить',
    this.cancelText = 'Отмена',
    this.onConfirm,
    this.onCancel,
    this.isConfirmDestructive = false,
    this.showCancelButton = true,
    this.isConfirmEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color confirmButtonColor = isConfirmDestructive
        ? isConfirmEnabled
            ? context.color.errorColor.withValues(alpha: 0.3)
            : Colors.transparent
        : isConfirmEnabled
            ? context.color.primaryColor.withValues(alpha: 0.3)
            : context.color.disableColor.withValues(alpha: 0.4);
    return AlertDialog(
      backgroundColor: context.color.backgroundColor,
      surfaceTintColor: context.color.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 16, 0),
      title: title != null
          ? Text(
              title!,
              style:
                  context.text.titleSmall.copyWith(fontWeight: FontWeight.w500),
            )
          : null,
      content: customContent ??
          (content != null
              ? Text(content!,
                  style: UIConstants.getAlertDialogContentTextStyle(context))
              : null),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      actions: [
        Row(
          children: [
            if (showCancelButton) ...[
              Expanded(
                child: CustomButton(
                  style: BoxDecoration(
                      color:
                          context.color.secondaryColor.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(8)),
                  height: 40,
                  onPressed: onCancel ?? () => Navigator.of(context).pop(),
                  label: Text(
                    cancelText.toUpperCase(),
                    style: context.text.bodySmall.copyWith(
                      color: context.color.secondaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const HorizontalGap(8),
            ],
            Expanded(
              child: CustomButton(
                height: 40,
                style: BoxDecoration(
                    color: confirmButtonColor,
                    borderRadius: BorderRadius.circular(8)),
                onPressed:
                    onConfirm != null && isConfirmEnabled ? onConfirm! : () {},
                label: Text(
                  confirmText.toUpperCase(),
                  style: context.text.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isConfirmDestructive
                        ? context.color.errorColor
                        : isConfirmEnabled
                            ? context.color.primaryColor
                            : context.color.disableColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
