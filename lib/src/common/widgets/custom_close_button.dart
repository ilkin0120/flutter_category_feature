import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import 'custom_button.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback onClick;

  const CustomCloseButton({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onClick,
      icon: Icon(size: 24, Icons.close, color: context.color.errorColor),
    );
  }
}
