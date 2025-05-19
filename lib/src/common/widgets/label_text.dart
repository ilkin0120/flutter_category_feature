import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;

  const LabelText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text.toUpperCase(),
        style: context.text.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: context.color.secondaryTextColor));
  }
}
