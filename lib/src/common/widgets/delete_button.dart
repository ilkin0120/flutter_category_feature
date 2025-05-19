import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onClick;

  const DeleteButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onClick,
      icon: Icon(
        Icons.delete_outline_rounded,
        color: context.color.errorColor,
      ),
    );
  }
}
