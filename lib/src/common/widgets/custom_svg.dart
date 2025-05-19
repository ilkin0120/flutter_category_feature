import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  final String asset;
  final Color color;
  final double width;
  final double height;

  const CustomSvg(
      {super.key,
      required this.asset,
      required this.color,
      this.width = 24,
      this.height = 24});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: width,
      height: height,
    );
  }
}
