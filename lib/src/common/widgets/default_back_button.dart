import 'package:flutter/material.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';

import '../constants/assets.dart';
import 'custom_button.dart';
import 'custom_svg.dart';

class DefaultBackButton extends StatelessWidget {
  final VoidCallback onBackClick;

  const DefaultBackButton({super.key, required this.onBackClick});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      width: 24,
      height: 24,
      onPressed: onBackClick,
      svgIcon: CustomSvg(
        asset: Assets.icons.leftArrow,
        color: context.color.secondaryTextColor,
      ),
    );
  }
}
