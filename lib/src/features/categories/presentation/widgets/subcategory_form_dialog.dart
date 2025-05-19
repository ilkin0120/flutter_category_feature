import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_alert_dialog.dart';
import '../../../../common/widgets/custom_gap.dart';
import '../../../../common/widgets/custom_text_field.dart';

class SubcategoryFormDialog extends StatefulWidget {
  final Function(String) onClick;

  final String? subcategoryName;

  final int maxLength;

  const SubcategoryFormDialog({
    super.key,
    required this.onClick,
    this.subcategoryName,
    this.maxLength = 20,
  });

  @override
  State<SubcategoryFormDialog> createState() => _SubcategoryFormDialogState();
}

class _SubcategoryFormDialogState extends State<SubcategoryFormDialog> {
  bool addEnabled = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.subcategoryName != null) {
      _controller.text = widget.subcategoryName!;
    }
    super.initState();
  }

  void _handleAdd() {
    widget.onClick(_controller.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: widget.subcategoryName != null ? "Изменить" : "Добавить",
      customContent: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VerticalGap(8),
          CustomTextField(
            controller: _controller,
            hintText: "Например: Бензин",
            onChanged:
                (value) => setState(
                  () =>
                      addEnabled =
                          value.trim().isNotEmpty &&
                          value != widget.subcategoryName,
                ),
            borderVisible: true,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          ),
          const VerticalGap(8),
        ],
      ),
      showCancelButton: true,
      confirmText: widget.subcategoryName != null ? "ПРИМЕНИТЬ" : "ДОБАВИТЬ",
      onConfirm: _handleAdd,
      isConfirmEnabled: addEnabled,
    );
  }
}
