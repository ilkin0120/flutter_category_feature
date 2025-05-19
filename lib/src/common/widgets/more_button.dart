import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../constants/ui_constants.dart';

class MoreButton extends StatelessWidget {
  final VoidCallback onTap;

  const MoreButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: UnconstrainedBox(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: context.color.primaryColor, width: 1),
            borderRadius: UIConstants.defaultBorderRadius,
          ),
          child: Icon(
            Icons.more_horiz_outlined,
            color: context.color.primaryColor,
          ),
        ),
      ),
    );
  }
}
