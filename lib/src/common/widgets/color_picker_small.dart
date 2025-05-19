import 'package:flutter_category_feature/src/common/constants/ui_constants.dart';
import 'package:flutter_category_feature/src/common/extensions/context_ext.dart';
import 'package:flutter_category_feature/src/routes/route_names.dart';
import 'package:flutter/material.dart';

class ColorPickerSmall extends StatelessWidget {
  final List<Color> colors;
  final Color selectedColor;
  final Function(Color) onColorSelected;
  final bool isCircle;

  const ColorPickerSmall(
      {super.key,
      required this.colors,
      required this.onColorSelected,
      required this.selectedColor,
      this.isCircle = false});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...colors.take(10).map((color) => _colorBox(context, color, isCircle)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, allColorsRoute, arguments: {
            'onClick': onColorSelected,
            'previousColor': selectedColor,
            'isCircle': isCircle
          }),
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: isCircle
                  ? BorderRadius.circular(90)
                  : UIConstants.defaultBorderRadius,
              border: Border.all(color: context.color.primaryColor, width: 1),
            ),
            child: Center(
              child: Text(
                "+",
                style: context.text.bodyMedium.copyWith(
                    color: context.color.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _colorBox(BuildContext context, Color color, bool isCircle) {
    return GestureDetector(
      onTap: () {
        onColorSelected(color);
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          borderRadius: isCircle
              ? BorderRadius.circular(90)
              : UIConstants.defaultBorderRadius,
          border: selectedColor == color
              ? Border.all(color: context.color.secondaryColor, width: 2)
              : null,
        ),
      ),
    );
  }
}
