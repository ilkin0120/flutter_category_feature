import 'package:flutter_category_feature/src/common/widgets/custom_button.dart';
import 'package:flutter_category_feature/src/common/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

import '../constants/assets.dart';

class CheckButton extends StatelessWidget {
  final Color color;
  final VoidCallback onClick;

  const CheckButton({super.key, required this.color, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onClick,
      svgIcon: CustomSvg(asset: Assets.icons.check, color: color),
    );
  }
}
